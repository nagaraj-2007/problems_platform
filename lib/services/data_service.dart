import '../models/models.dart';

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
    // IT / Software
    Problem(id: 'p1', title: 'Remote team communication inefficiency', category: 'IT / Software', context: 'Our distributed team struggles with async communication. Messages get lost, decisions are delayed, and team members feel disconnected from project progress.', authorId: 'user2', authorName: 'Alice Johnson', createdAt: DateTime.now().subtract(Duration(days: 2)), planCount: 1, averageRating: 4.5, reviewCount: 2, likeCount: 15, imageUrls: ['assets/images/image.png']),
    Problem(id: 'p2', title: 'Legacy system integration challenges', category: 'IT / Software', context: 'Need to integrate modern APIs with 20-year-old mainframe systems without disrupting critical business operations.', authorId: 'user3', authorName: 'Bob Smith', createdAt: DateTime.now().subtract(Duration(days: 3)), planCount: 0, likeCount: 8),
    Problem(id: 'p3', title: 'Database performance bottlenecks', category: 'IT / Software', context: 'Query response times have increased 300% over the past month, affecting user experience across all applications.', authorId: 'user4', authorName: 'Carol Davis', createdAt: DateTime.now().subtract(Duration(days: 1)), planCount: 2, likeCount: 22),
    Problem(id: 'p4', title: 'Security vulnerability in authentication system', category: 'IT / Software', context: 'Recent security audit revealed potential SQL injection vulnerabilities in our user authentication module.', authorId: 'user5', authorName: 'David Wilson', createdAt: DateTime.now().subtract(Duration(days: 4)), planCount: 3, likeCount: 45, imageUrls: ['assets/images/image copy.png']),
    Problem(id: 'p5', title: 'Mobile app crashes on iOS 17', category: 'IT / Software', context: 'Users report frequent crashes after iOS 17 update, particularly when accessing camera features.', authorId: 'user6', authorName: 'Emma Brown', createdAt: DateTime.now().subtract(Duration(days: 5)), planCount: 1, likeCount: 12),
    Problem(id: 'p6', title: 'Cloud migration cost overruns', category: 'IT / Software', context: 'AWS costs are 40% higher than projected, need strategies to optimize resource usage and reduce expenses.', authorId: 'user7', authorName: 'Frank Miller', createdAt: DateTime.now().subtract(Duration(days: 6)), planCount: 2, likeCount: 18),
    Problem(id: 'p7', title: 'API rate limiting issues', category: 'IT / Software', context: 'Third-party API calls are being throttled, causing service disruptions during peak hours.', authorId: 'user8', authorName: 'Grace Lee', createdAt: DateTime.now().subtract(Duration(days: 7)), planCount: 1, likeCount: 9),
    Problem(id: 'p8', title: 'Docker container memory leaks', category: 'IT / Software', context: 'Production containers are consuming increasing amounts of memory over time, requiring frequent restarts.', authorId: 'user9', authorName: 'Henry Chen', createdAt: DateTime.now().subtract(Duration(days: 8)), planCount: 0, likeCount: 5),
    Problem(id: 'p9', title: 'Microservices communication latency', category: 'IT / Software', context: 'Inter-service communication is adding significant latency to user requests, affecting overall system performance.', authorId: 'user10', authorName: 'Ivy Taylor', createdAt: DateTime.now().subtract(Duration(days: 9)), planCount: 2, likeCount: 14),
    Problem(id: 'p10', title: 'Code deployment pipeline failures', category: 'IT / Software', context: 'CI/CD pipeline fails intermittently, causing delays in feature releases and hotfixes.', authorId: 'user11', authorName: 'Jack Anderson', createdAt: DateTime.now().subtract(Duration(days: 10)), planCount: 1, likeCount: 7),

    // Agriculture
    Problem(id: 'p11', title: 'Soil degradation in wheat fields', category: 'Agriculture', context: 'Continuous monoculture has led to significant soil quality decline, affecting crop yields and sustainability.', authorId: 'user12', authorName: 'Kate Farmer', createdAt: DateTime.now().subtract(Duration(days: 11)), planCount: 2, likeCount: 33),
    Problem(id: 'p12', title: 'Water scarcity for irrigation', category: 'Agriculture', context: 'Drought conditions have reduced water availability by 60%, threatening crop survival.', authorId: 'user13', authorName: 'Luke Green', createdAt: DateTime.now().subtract(Duration(days: 12)), planCount: 3, likeCount: 56, imageUrls: ['assets/images/image copy 2.png']),
    Problem(id: 'p13', title: 'Pest resistance to pesticides', category: 'Agriculture', context: 'Common pests have developed resistance to standard pesticides, requiring new integrated pest management strategies.', authorId: 'user14', authorName: 'Mary Fields', createdAt: DateTime.now().subtract(Duration(days: 13)), planCount: 1, likeCount: 11),
    Problem(id: 'p14', title: 'Labor shortage during harvest', category: 'Agriculture', context: 'Unable to find sufficient seasonal workers for harvest, risking crop loss and reduced income.', authorId: 'user15', authorName: 'Nick Harvest', createdAt: DateTime.now().subtract(Duration(days: 14)), planCount: 2, likeCount: 19),
    Problem(id: 'p15', title: 'Climate change impact on crop timing', category: 'Agriculture', context: 'Unpredictable weather patterns are disrupting traditional planting and harvesting schedules.', authorId: 'user16', authorName: 'Olivia Crop', createdAt: DateTime.now().subtract(Duration(days: 15)), planCount: 1, likeCount: 23),
    Problem(id: 'p16', title: 'Organic certification compliance costs', category: 'Agriculture', context: 'High costs and complex paperwork for organic certification are preventing small farmers from accessing premium markets.', authorId: 'user17', authorName: 'Paul Organic', createdAt: DateTime.now().subtract(Duration(days: 16)), planCount: 0, likeCount: 6),
    Problem(id: 'p17', title: 'Equipment maintenance and repair costs', category: 'Agriculture', context: 'Aging farm equipment requires frequent expensive repairs, impacting profitability and operational efficiency.', authorId: 'user18', authorName: 'Quinn Mechanic', createdAt: DateTime.now().subtract(Duration(days: 17)), planCount: 2, likeCount: 15),
    Problem(id: 'p18', title: 'Market price volatility for crops', category: 'Agriculture', context: 'Unpredictable commodity prices make it difficult to plan investments and ensure stable income.', authorId: 'user19', authorName: 'Rachel Market', createdAt: DateTime.now().subtract(Duration(days: 18)), planCount: 1, likeCount: 20),
    Problem(id: 'p19', title: 'Livestock disease outbreak prevention', category: 'Agriculture', context: 'Need effective strategies to prevent and manage disease outbreaks in cattle herds without overusing antibiotics.', authorId: 'user20', authorName: 'Sam Rancher', createdAt: DateTime.now().subtract(Duration(days: 19)), planCount: 3, likeCount: 42),
    Problem(id: 'p20', title: 'Sustainable farming practice adoption', category: 'Agriculture', context: 'Transitioning to sustainable practices while maintaining productivity and profitability is challenging.', authorId: 'user21', authorName: 'Tina Sustain', createdAt: DateTime.now().subtract(Duration(days: 20)), planCount: 2, likeCount: 28),

    // Business / Startup
    Problem(id: 'p21', title: 'Customer acquisition cost too high', category: 'Business / Startup', context: 'CAC has increased 200% while customer lifetime value remains flat, making growth unsustainable.', authorId: 'user22', authorName: 'Uma Startup', createdAt: DateTime.now().subtract(Duration(days: 21)), planCount: 2, likeCount: 67),
    Problem(id: 'p22', title: 'Cash flow management challenges', category: 'Business / Startup', context: 'Irregular revenue and high upfront costs are creating cash flow gaps that threaten operations.', authorId: 'user23', authorName: 'Victor Finance', createdAt: DateTime.now().subtract(Duration(days: 22)), planCount: 1, likeCount: 31),
    Problem(id: 'p23', title: 'Scaling team culture remotely', category: 'Business / Startup', context: 'Maintaining company culture and values while rapidly scaling a distributed team across time zones.', authorId: 'user24', authorName: 'Wendy Culture', createdAt: DateTime.now().subtract(Duration(days: 23)), planCount: 3, likeCount: 45),
    Problem(id: 'p24', title: 'Product-market fit validation', category: 'Business / Startup', context: 'Uncertain whether current product features align with actual market needs and customer pain points.', authorId: 'user25', authorName: 'Xavier Product', createdAt: DateTime.now().subtract(Duration(days: 24)), planCount: 2, likeCount: 38),
    Problem(id: 'p25', title: 'Investor pitch deck effectiveness', category: 'Business / Startup', context: 'Multiple pitch rejections suggest our value proposition and market opportunity are not clearly communicated.', authorId: 'user26', authorName: 'Yara Pitch', createdAt: DateTime.now().subtract(Duration(days: 25)), planCount: 1, likeCount: 22),
    Problem(id: 'p26', title: 'Competitor analysis and differentiation', category: 'Business / Startup', context: 'New competitors are entering the market with similar features, need to identify unique value propositions.', authorId: 'user27', authorName: 'Zoe Compete', createdAt: DateTime.now().subtract(Duration(days: 26)), planCount: 0, likeCount: 14),
    Problem(id: 'p27', title: 'Regulatory compliance for fintech', category: 'Business / Startup', context: 'Navigating complex financial regulations while maintaining product innovation and user experience.', authorId: 'user28', authorName: 'Adam Comply', createdAt: DateTime.now().subtract(Duration(days: 27)), planCount: 2, likeCount: 29),
    Problem(id: 'p28', title: 'International market expansion strategy', category: 'Business / Startup', context: 'Planning expansion to European markets while managing cultural differences and local regulations.', authorId: 'user29', authorName: 'Beth Global', createdAt: DateTime.now().subtract(Duration(days: 28)), planCount: 1, likeCount: 18),
    Problem(id: 'p29', title: 'Technical debt vs feature development', category: 'Business / Startup', context: 'Balancing time between fixing technical debt and developing new features to meet market demands.', authorId: 'user30', authorName: 'Carl Tech', createdAt: DateTime.now().subtract(Duration(days: 29)), planCount: 3, likeCount: 52),
    Problem(id: 'p30', title: 'Customer churn rate increasing', category: 'Business / Startup', context: 'Monthly churn has increased from 5% to 12%, need to identify causes and implement retention strategies.', authorId: 'user1', authorName: 'Current User', createdAt: DateTime.now().subtract(Duration(days: 1)), planCount: 0, likeCount: 10, imageUrls: ['assets/images/image copy 3.png']),
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
      likeCount: 5,
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
        likeCount: problem.likeCount,
        imageUrls: problem.imageUrls,
        videoUrls: problem.videoUrls,
        isLiked: problem.isLiked,
      );
    }
  }

  void addProblemReview(ProblemReview review) {
    _problemReviews.add(review);
  }

  void addPlanRating(PlanRating rating) {
    _planRatings.add(rating);
  }

  // Like Methods
  void likeProblem(String problemId) {
    final index = _problems.indexWhere((p) => p.id == problemId);
    if (index != -1) {
      final problem = _problems[index];
      _problems[index] = Problem(
        id: problem.id,
        title: problem.title,
        category: problem.category,
        context: problem.context,
        authorId: problem.authorId,
        authorName: problem.authorName,
        createdAt: problem.createdAt,
        planCount: problem.planCount,
        averageRating: problem.averageRating,
        reviewCount: problem.reviewCount,
        imageUrls: problem.imageUrls,
        videoUrls: problem.videoUrls,
        likeCount: problem.isLiked ? problem.likeCount - 1 : problem.likeCount + 1,
        isLiked: !problem.isLiked,
      );
    }
  }

  void likePlan(String planId) {
    final index = _plans.indexWhere((p) => p.id == planId);
    if (index != -1) {
      final plan = _plans[index];
      _plans[index] = Plan(
        id: plan.id,
        problemId: plan.problemId,
        authorId: plan.authorId,
        authorName: plan.authorName,
        steps: plan.steps,
        createdAt: plan.createdAt,
        averageRating: plan.averageRating,
        ratingCount: plan.ratingCount,
        likeCount: plan.isLiked ? plan.likeCount - 1 : plan.likeCount + 1,
        isLiked: !plan.isLiked,
      );
    }
  }
}