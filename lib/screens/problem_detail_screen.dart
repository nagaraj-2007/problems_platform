import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../widgets/components.dart';
import 'submit_plan_screen.dart';
import '../utils/theme.dart';

class ProblemDetailScreen extends StatelessWidget {
  final String problemId;

  const ProblemDetailScreen({super.key, required this.problemId});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final problem = dataService.getProblem(problemId);
    final plans = dataService.getPlansForProblem(problemId);
    final problemReviews = dataService.getProblemReviews(problemId);
    final canSubmitPlan = dataService.canSubmitPlan(problemId);
    final canReviewProblem = dataService.canReviewProblem(problemId);

    if (problem == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Problem Not Found')),
        body: const Center(child: Text('Problem not found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Problem Section
              Text(
                problem.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              
              // Media Section
              if (problem.imageUrl != null) ...[
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [AppTheme.softShadow], 
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          problem.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              Container(color: Colors.grey.shade200, child: const Center(child: Icon(Icons.error))),
                        ),
                        if (problem.videoUrl != null)
                          Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.7),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(Icons.play_arrow, color: Colors.white, size: 36),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
              
              Row(
                children: [
                  CategoryTag(category: problem.category),
                  const SizedBox(width: 16),
                  Text(
                    'Posted by ${problem.authorName}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    _formatDate(problem.createdAt),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  problem.context,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Problem Reviews Section
              Row(
                children: [
                  const Text(
                    'Problem Reviews',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${problemReviews.length})',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500
                    ),
                  ),
                  const Spacer(),
                  if (canReviewProblem)
                    TextButton(
                      onPressed: () => _showReviewDialog(context, problem),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('Add Review'),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              if (problemReviews.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'No reviews yet',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              else
                ...problemReviews.map((review) => ReviewCard(
                  reviewerName: review.reviewerName,
                  rating: review.rating,
                  comment: review.comment,
                  createdAt: review.createdAt,
                )),
              const SizedBox(height: 40),

              // Warning Banner
              if (!canSubmitPlan)
                const WarningBanner(
                  message: 'You cannot submit plans to your own problem',
                ),

              // Plans Section
              Row(
                children: [
                  const Text(
                    'Plans',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                   Text(
                    '(${plans.length})',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500
                    ),
                  ),
                  const Spacer(),
                  if (canSubmitPlan)
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubmitPlanScreen(problem: problem),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('Submit Plan'),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Plans List
              if (plans.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No plans submitted yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Be the first to submit a structured plan',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                )
              else
                ...plans.map((plan) => _buildPlanWithRatings(context, plan)),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanWithRatings(BuildContext context, Plan plan) {
    final dataService = DataService();
    final planRatings = dataService.getPlanRatings(plan.id);
    final canRate = dataService.canRatePlan(plan.id);

    return Column(
      children: [
        PlanCard(plan: plan),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Ratings',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                   const SizedBox(width: 8),
                   Text(
                    '(${planRatings.length})',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade500),
                  ),
                  const Spacer(),
                  if (canRate)
                    TextButton(
                      onPressed: () => _showRatingDialog(context, plan),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text('Rate Plan'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (planRatings.isEmpty)
                Text(
                  'No ratings yet',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                )
              else
                ...planRatings.map((rating) => ReviewCard(
                  reviewerName: rating.raterName,
                  rating: rating.rating,
                  comment: rating.comment,
                  createdAt: rating.createdAt,
                )),
            ],
          ),
        ),
      ],
    );
  }

  void _showReviewDialog(BuildContext context, Problem problem) {
    // Simple rating dialog - in real app would be more sophisticated
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Review Problem'),
        content: const Text('Problem review functionality would be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context, Plan plan) {
    // Simple rating dialog - in real app would be more sophisticated
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate Plan'),
        content: const Text('Plan rating functionality would be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}