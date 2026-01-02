import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../widgets/components.dart';
import 'problem_preview_screen.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
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
            // User Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.person, size: 32, color: Colors.grey.shade600),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataService.currentUserName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Member since ${DateTime.now().year}',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      _buildStatCard('Problems Posted', userProblems.length.toString()),
                      SizedBox(width: 16),
                      _buildStatCard('Plans Submitted', userPlans.length.toString()),
                      SizedBox(width: 16),
                      _buildStatCard('Clarity Votes', userPlans.fold(0, (sum, plan) => sum + plan.ratingCount).toString()),
                    ],
                  ),
                ],
              ),
            ),

            // Activity Tabs
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: 'My Problems'),
                Tab(text: 'My Plans'),
              ],
            ),
            SizedBox(height: 20),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // My Problems Tab
                  userProblems.isEmpty
                      ? _buildEmptyState('No problems posted yet', Icons.lightbulb_outline)
                      : ListView.builder(
                          itemCount: userProblems.length,
                          itemBuilder: (context, index) {
                            final problem = userProblems[index];
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

                  // My Plans Tab
                  userPlans.isEmpty
                      ? _buildEmptyState('No plans submitted yet', Icons.assignment_outlined)
                      : ListView.builder(
                          itemCount: userPlans.length,
                          itemBuilder: (context, index) {
                            final plan = userPlans[index];
                            final problem = dataService.getProblem(plan.problemId);
                            return Card(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Plan for: ${problem?.title ?? 'Unknown Problem'}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${plan.steps.length} steps • ${plan.ratingCount} ratings',
                                      style: TextStyle(color: Colors.grey.shade600),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      plan.steps.first.title,
                                      style: TextStyle(color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey.shade400),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
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