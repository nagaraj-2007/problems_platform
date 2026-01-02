import 'models.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final String currentUserId = 'user1';
  final String currentUserName = 'Current User';

  static const List<String> categories = [
    'IT / Software',
    'Agriculture',
    'Business / Startup',
    'Finance (non-trading, general)',
    'Career / Jobs',
    'Education / Learning',
    'Healthcare',
    'Manufacturing',
    'Marketing / Sales',
    'Operations / Process',
    'Human Resources',
    'Legal / Compliance',
    'Real Estate',
    'Logistics / Supply Chain',
    'Retail / E-commerce',
    'Government / Public Services',
    'Environment / Sustainability',
    'Product / UX / Design',
    'Data / Analytics',
    'Security / Risk',
    'Social / Community',
    'Personal Productivity',
    'Research / Innovation',
    'Other (Uncategorized)',
  ];

  final List<Problem> _problems = [
    Problem(
      id: 'p1',
      title: 'Remote team communication inefficiency',
      category: 'IT / Software',
      context: 'Our distributed team struggles with async communication. Messages get lost, decisions are delayed, and team members feel disconnected from project progress.',
      authorId: 'user2',
      authorName: 'Alice Johnson',
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      planCount: 1,
      averageRating: 4.5,
      reviewCount: 2,
      viewCount: 127,
    ),
    Problem(
      id: 'p2',
      title: 'Customer onboarding dropout rate',
      category: 'Product / UX / Design',
      context: 'New users abandon our onboarding process at 60% rate. Analytics show they drop off after the third step, but we need structured approaches to identify and fix the core issues.',
      authorId: 'user1',
      authorName: 'Current User',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      planCount: 0,
      viewCount: 89,
    ),
  ];

  final List<ProblemReview> _problemReviews = [
    ProblemReview(
      id: 'pr1',
      problemId: 'p1',
      reviewerId: 'user3',
      reviewerName: 'Bob Smith',
      rating: 5,
      comment: 'Very clear problem description with good context',
      createdAt: DateTime.now().subtract(Duration(hours: 6)),
    ),
    ProblemReview(
      id: 'pr2',
      problemId: 'p1',
      reviewerId: 'user4',
      reviewerName: 'Carol Davis',
      rating: 4,
      comment: 'Important issue that needs addressing',
      createdAt: DateTime.now().subtract(Duration(hours: 3)),
    ),
  ];

  final List<Plan> _plans = [
    Plan(
      id: 'plan1',
      problemId: 'p1',
      authorId: 'user1',
      authorName: 'Current User',
      createdAt: DateTime.now().subtract(Duration(hours: 12)),
      averageRating: 4.5,
      ratingCount: 2,
      steps: [
        PlanStep(title: 'Audit current communication tools', description: 'Document all channels, frequency, and response times across the team'),
        PlanStep(title: 'Survey team members', description: 'Gather specific pain points and preferred communication styles'),
        PlanStep(title: 'Implement structured check-ins', description: 'Create daily async updates and weekly sync meetings'),
      ],
    ),
  ];

  final List<PlanRating> _planRatings = [
    PlanRating(
      id: 'plr1',
      planId: 'plan1',
      raterId: 'user3',
      raterName: 'Bob Smith',
      rating: 5,
      comment: 'Comprehensive and actionable plan',
      createdAt: DateTime.now().subtract(Duration(hours: 4)),
    ),
    PlanRating(
      id: 'plr2',
      planId: 'plan1',
      raterId: 'user4',
      raterName: 'Carol Davis',
      rating: 4,
      comment: 'Good structure, could use more detail on implementation',
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
    ),
  ];

  List<Problem> getProblems() => List.from(_problems);
  
  Problem? getProblem(String id) => _problems.firstWhere((p) => p.id == id);
  
  List<Plan> getPlansForProblem(String problemId) => 
      _plans.where((p) => p.problemId == problemId).toList();

  List<Plan> getAllPlans() => List.from(_plans);

  List<ProblemReview> getProblemReviews(String problemId) =>
      _problemReviews.where((r) => r.problemId == problemId).toList();

  List<PlanRating> getPlanRatings(String planId) =>
      _planRatings.where((r) => r.planId == planId).toList();

  bool canSubmitPlan(String problemId) {
    final problem = getProblem(problemId);
    return problem?.authorId != currentUserId;
  }

  bool canReviewProblem(String problemId) {
    final problem = getProblem(problemId);
    return problem?.authorId != currentUserId;
  }

  bool canRatePlan(String planId) {
    final plan = _plans.firstWhere((p) => p.id == planId);
    return plan.authorId != currentUserId;
  }

  void addProblem(Problem problem) {
    _problems.insert(0, problem);
  }

  void addPlan(Plan plan) {
    _plans.add(plan);
    final problemIndex = _problems.indexWhere((p) => p.id == plan.problemId);
    if (problemIndex != -1) {
      final problem = _problems[problemIndex];
      _problems[problemIndex] = Problem(
        id: problem.id,
        title: problem.title,
        category: problem.category,
        context: problem.context,
        authorId: problem.authorId,
        authorName: problem.authorName,
        createdAt: problem.createdAt,
        planCount: problem.planCount + 1,
        averageRating: problem.averageRating,
        reviewCount: problem.reviewCount,
        viewCount: problem.viewCount,
      );
    }
  }

  void addProblemReview(ProblemReview review) {
    _problemReviews.add(review);
  }

  void addPlanRating(PlanRating rating) {
    _planRatings.add(rating);
  }
}