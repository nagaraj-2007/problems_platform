import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../widgets/components.dart';
import '../utils/linkedin_theme.dart';
import 'problem_preview_screen.dart';
import 'post_problem_screen.dart';
import 'category_overview_screen.dart';
import 'problem_list_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final userProblems = dataService.getProblems()
        .where((p) => p.authorId == dataService.currentUserId)
        .toList();
    final userPlans = dataService.getAllPlans()
        .where((p) => p.authorId == dataService.currentUserId)
        .toList();

    return Scaffold(
      backgroundColor: LinkedInTheme.backgroundGray,
      appBar: AppBar(
        backgroundColor: LinkedInTheme.cardWhite,
        elevation: 0,
        title: const Text('Profile', style: LinkedInTheme.heading2),
        iconTheme: const IconThemeData(color: LinkedInTheme.textPrimary),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: LinkedInTheme.textPrimary),
            onSelected: (value) {
              switch (value) {
                case 'add_problem':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostProblemScreen()),
                  );
                  break;
                case 'browse_categories':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CategoryOverviewScreen()),
                  );
                  break;
                case 'all_problems':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProblemListScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'add_problem',
                child: Row(
                  children: [
                    Icon(Icons.add, color: LinkedInTheme.textPrimary),
                    SizedBox(width: 8),
                    Text('Add Problem'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'browse_categories',
                child: Row(
                  children: [
                    Icon(Icons.category, color: LinkedInTheme.textPrimary),
                    SizedBox(width: 8),
                    Text('Browse Categories'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'all_problems',
                child: Row(
                  children: [
                    Icon(Icons.list, color: LinkedInTheme.textPrimary),
                    SizedBox(width: 8),
                    Text('All Problems'),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: LinkedInTheme.borderGray),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Card
            Container(
              width: double.infinity,
              decoration: LinkedInTheme.cardDecoration,
              child: Column(
                children: [
                  // Cover area with gradient
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [LinkedInTheme.primaryBlue, LinkedInTheme.darkBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                  ),
                  // Profile content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Profile picture overlapping cover
                        Transform.translate(
                          offset: const Offset(0, -50),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: LinkedInTheme.cardWhite, width: 4),
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: LinkedInTheme.lightBlue,
                              child: Text(
                                dataService.currentUserName[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: LinkedInTheme.primaryBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // User info
                        Transform.translate(
                          offset: const Offset(0, -30),
                          child: Column(
                            children: [
                              Text(
                                dataService.currentUserName,
                                style: LinkedInTheme.heading1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Problem Solver • Community Member',
                                style: LinkedInTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Member since ${DateTime.now().year}',
                                style: LinkedInTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Problems',
                    userProblems.length.toString(),
                    Icons.lightbulb_outline,
                    LinkedInTheme.primaryBlue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Solutions',
                    userPlans.length.toString(),
                    Icons.psychology_outlined,
                    LinkedInTheme.successGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Ratings',
                    userPlans.fold(0, (sum, plan) => sum + plan.ratingCount).toString(),
                    Icons.star_outline,
                    LinkedInTheme.warningOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Activity Section
            Container(
              decoration: LinkedInTheme.cardDecoration,
              child: Column(
                children: [
                  // Tab Header
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: LinkedInTheme.borderGray)),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: LinkedInTheme.primaryBlue,
                      unselectedLabelColor: LinkedInTheme.textSecondary,
                      indicatorColor: LinkedInTheme.primaryBlue,
                      indicatorWeight: 2,
                      labelStyle: LinkedInTheme.heading3,
                      unselectedLabelStyle: LinkedInTheme.bodyMedium,
                      tabs: const [
                        Tab(text: 'My Problems'),
                        Tab(text: 'My Solutions'),
                      ],
                    ),
                  ),
                  // Tab Content
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // My Problems Tab
                        _buildProblemsTab(userProblems),
                        // My Plans Tab
                        _buildPlansTab(userPlans, dataService),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: LinkedInTheme.cardDecoration,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: LinkedInTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: LinkedInTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProblemsTab(List userProblems) {
    if (userProblems.isEmpty) {
      return _buildEmptyState(
        'No problems posted yet',
        'Share a problem to get started',
        Icons.lightbulb_outline,
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostProblemScreen()),
          );
        },
        actionText: 'Post Problem',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: userProblems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final problem = userProblems[index];
        return Stack(
          children: [
            ProblemCard(
              problem: problem,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProblemPreviewScreen(problemId: problem.id),
                  ),
                );
              },
            ),
            Positioned(
              top: 8,
              right: 8,
              child: PopupMenuButton<String>(
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: LinkedInTheme.cardWhite.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.more_vert, size: 16, color: LinkedInTheme.textSecondary),
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditDialog(problem);
                  } else if (value == 'delete') {
                    _showDeleteDialog(problem);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 16, color: LinkedInTheme.textPrimary),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16, color: LinkedInTheme.warningOrange),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: LinkedInTheme.warningOrange)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlansTab(List userPlans, DataService dataService) {
    if (userPlans.isEmpty) {
      return _buildEmptyState(
        'No solutions submitted yet',
        'Help solve problems in the community',
        Icons.psychology_outlined,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: userPlans.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final plan = userPlans[index];
        final problem = dataService.getProblem(plan.problemId);
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: LinkedInTheme.cardWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: LinkedInTheme.borderGray),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: LinkedInTheme.successGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.psychology,
                      color: LinkedInTheme.successGreen,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      problem?.title ?? 'Unknown Problem',
                      style: LinkedInTheme.heading3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                plan.steps.first.description,
                style: LinkedInTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildPlanStat(Icons.star_outline, '${plan.averageRating.toStringAsFixed(1)}'),
                  const SizedBox(width: 16),
                  _buildPlanStat(Icons.people_outline, '${plan.ratingCount}'),
                  const Spacer(),
                  Text(
                    _formatDate(plan.createdAt),
                    style: LinkedInTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlanStat(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: LinkedInTheme.textSecondary),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: LinkedInTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon, {
    VoidCallback? onActionPressed,
    String? actionText,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: LinkedInTheme.backgroundGray,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                size: 48,
                color: LinkedInTheme.textTertiary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: LinkedInTheme.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: LinkedInTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onActionPressed != null && actionText != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onActionPressed,
                style: LinkedInTheme.primaryButton,
                child: Text(actionText, style: LinkedInTheme.buttonText),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    return '${difference.inMinutes}m ago';
  }

  void _showEditDialog(Problem problem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Problem'),
        content: const Text('Edit functionality would be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Problem problem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Problem'),
        content: Text('Are you sure you want to delete "${problem.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Delete functionality would be implemented here
            },
            style: TextButton.styleFrom(foregroundColor: LinkedInTheme.warningOrange),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}