import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import 'category_problems_screen.dart';

class CategoryOverviewScreen extends StatelessWidget {
  const CategoryOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final problems = dataService.getProblems();
    final categories = _getCategoryStats(problems);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 800),
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Browse problems by category',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategoryCard(context, category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryStats category) {
    final colors = _getCategoryColors(category.name);
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colors['border']!),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryProblemsScreen(category: category.name),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colors['background']!, Colors.white],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors['icon'],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getCategoryIcon(category.name),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors['badge'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${category.problemCount}',
                      style: TextStyle(
                        color: colors['badgeText'],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${category.problemCount} problems',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              Text(
                '${category.totalPlans.toInt()} total plans',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
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

  Map<String, Color> _getCategoryColors(String category) {
    switch (category) {
      case 'Management':
        return {
          'background': Colors.blue.shade50,
          'border': Colors.blue.shade200,
          'icon': Colors.blue.shade600,
          'badge': Colors.blue.shade100,
          'badgeText': Colors.blue.shade700,
        };
      case 'Product':
        return {
          'background': Colors.green.shade50,
          'border': Colors.green.shade200,
          'icon': Colors.green.shade600,
          'badge': Colors.green.shade100,
          'badgeText': Colors.green.shade700,
        };
      case 'Technical':
        return {
          'background': Colors.purple.shade50,
          'border': Colors.purple.shade200,
          'icon': Colors.purple.shade600,
          'badge': Colors.purple.shade100,
          'badgeText': Colors.purple.shade700,
        };
      case 'Strategy':
        return {
          'background': Colors.orange.shade50,
          'border': Colors.orange.shade200,
          'icon': Colors.orange.shade600,
          'badge': Colors.orange.shade100,
          'badgeText': Colors.orange.shade700,
        };
      default:
        return {
          'background': Colors.grey.shade50,
          'border': Colors.grey.shade200,
          'icon': Colors.grey.shade600,
          'badge': Colors.grey.shade100,
          'badgeText': Colors.grey.shade700,
        };
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Management':
        return Icons.people;
      case 'Product':
        return Icons.inventory;
      case 'Technical':
        return Icons.code;
      case 'Strategy':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
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