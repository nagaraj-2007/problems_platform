import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../utils/linkedin_theme.dart';
import 'category_problems_screen.dart';

class CategoryOverviewScreen extends StatelessWidget {
  const CategoryOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final problems = dataService.getProblems();
    final categories = _getCategoryStats(problems);

    return Scaffold(
      backgroundColor: LinkedInTheme.backgroundGray,
      appBar: AppBar(
        backgroundColor: LinkedInTheme.cardWhite,
        elevation: 0,
        title: const Text('Categories', style: LinkedInTheme.heading2),
        iconTheme: const IconThemeData(color: LinkedInTheme.textPrimary),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: LinkedInTheme.borderGray,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: LinkedInTheme.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Browse by Category', style: LinkedInTheme.heading1),
                  const SizedBox(height: 8),
                  Text(
                    'Find problems and solutions across different industries',
                    style: LinkedInTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildCategoryCard(context, category);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryStats category) {
    return Container(
      decoration: LinkedInTheme.cardDecoration,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryProblemsScreen(category: category.name),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: LinkedInTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      _getCategoryIcon(category.name),
                      color: LinkedInTheme.cardWhite,
                      size: 16,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: LinkedInTheme.lightBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${category.problemCount}',
                      style: const TextStyle(
                        color: LinkedInTheme.primaryBlue,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                style: LinkedInTheme.heading3,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${category.problemCount} problems',
                style: LinkedInTheme.bodySmall,
              ),
              Text(
                '${category.totalPlans.toInt()} solutions',
                style: LinkedInTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CategoryStats> _getCategoryStats(List<Problem> problems) {
    final Map<String, CategoryStats> stats = {};
    
    for (final problem in problems) {
      if (!stats.containsKey(problem.category)) {
        stats[problem.category] = CategoryStats(
          name: problem.category,
          problemCount: 0,
          totalPlans: 0.0,
        );
      }
      stats[problem.category]!.problemCount++;
      stats[problem.category]!.totalPlans += problem.planCount;
    }
    
    return stats.values.toList()..sort((a, b) => b.problemCount.compareTo(a.problemCount));
  }

  IconData _getCategoryIcon(String category) {
    if (category.contains('IT') || category.contains('Software')) return Icons.computer;
    if (category.contains('Agriculture')) return Icons.agriculture;
    if (category.contains('Business') || category.contains('Startup')) return Icons.business;
    if (category.contains('Finance')) return Icons.account_balance;
    if (category.contains('Career') || category.contains('Jobs')) return Icons.work;
    if (category.contains('Education')) return Icons.school;
    if (category.contains('Healthcare')) return Icons.local_hospital;
    if (category.contains('Manufacturing')) return Icons.factory;
    if (category.contains('Marketing')) return Icons.campaign;
    return Icons.category;
  }
}

class CategoryStats {
  final String name;
  int problemCount;
  double totalPlans;

  CategoryStats({
    required this.name,
    required this.problemCount,
    required this.totalPlans,
  });
}