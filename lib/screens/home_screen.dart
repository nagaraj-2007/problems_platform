import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../widgets/components.dart';
import '../utils/linkedin_theme.dart';
import 'problem_preview_screen.dart';
import 'problem_list_screen.dart';
import 'post_problem_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCategories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _filteredCategories = DataService.categories.take(8).toList();
    _searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    setState(() {
      _filteredCategories = DataService.categories
          .where((category) => category.toLowerCase().contains(_searchController.text.toLowerCase()))
          .take(8)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final allProblems = dataService.getProblems();
    final problems = _selectedCategory == null 
        ? allProblems.take(5).toList()
        : allProblems.where((p) => p.category == _selectedCategory).take(5).toList();

    return Scaffold(
      backgroundColor: LinkedInTheme.backgroundGray,
      appBar: AppBar(
        backgroundColor: LinkedInTheme.cardWhite,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/image copy 4.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 8),
            const Text('BrainLift', style: LinkedInTheme.heading2),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: LinkedInTheme.lightBlue,
              child: const Icon(Icons.person_outline, color: LinkedInTheme.primaryBlue, size: 18),
            ),
          ),
          const SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: LinkedInTheme.borderGray),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            _buildCategoryList(),
            _buildRecentProblemsSection(problems),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostProblemScreen()),
          );
        },
        backgroundColor: LinkedInTheme.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Post Problem', style: LinkedInTheme.buttonText),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        decoration: LinkedInTheme.inputDecoration('Search problems, categories...')
            .copyWith(
          prefixIcon: const Icon(Icons.search, color: LinkedInTheme.textSecondary),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text('Categories', style: LinkedInTheme.heading3),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              final category = _filteredCategories[index];
              final isSelected = _selectedCategory == category;
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = isSelected ? null : category;
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? LinkedInTheme.primaryBlue : LinkedInTheme.cardWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? LinkedInTheme.primaryBlue : LinkedInTheme.borderGray,
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? LinkedInTheme.cardWhite : LinkedInTheme.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentProblemsSection(List<Problem> problems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Row(
            children: [
              Text(
                _selectedCategory == null ? 'Recent Problems' : '$_selectedCategory Problems',
                style: LinkedInTheme.heading3,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProblemListScreen()),
                  );
                },
                child: const Text(
                  'View all',
                  style: TextStyle(color: LinkedInTheme.primaryBlue, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: problems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final problem = problems[index];
            return ProblemCard(
              problem: problem,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProblemPreviewScreen(problemId: problem.id),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}