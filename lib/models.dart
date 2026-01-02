class Problem {
  final String id;
  final String title;
  final String category;
  final String context;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final int planCount;
  final double averageRating;
  final int reviewCount;
  final int viewCount;
  final String? imageUrl;
  final String? videoUrl;

  Problem({
    required this.id,
    required this.title,
    required this.category,
    required this.context,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    this.planCount = 0,
    this.averageRating = 0.0,
    this.reviewCount = 0,
    this.viewCount = 0,
    this.imageUrl,
    this.videoUrl,
  });
}

class Plan {
  final String id;
  final String problemId;
  final String authorId;
  final String authorName;
  final List<PlanStep> steps;
  final DateTime createdAt;
  final double averageRating;
  final int ratingCount;

  Plan({
    required this.id,
    required this.problemId,
    required this.authorId,
    required this.authorName,
    required this.steps,
    required this.createdAt,
    this.averageRating = 0.0,
    this.ratingCount = 0,
  });
}

class PlanStep {
  final String title;
  final String description;

  PlanStep({required this.title, required this.description});
}

class ProblemReview {
  final String id;
  final String problemId;
  final String reviewerId;
  final String reviewerName;
  final int rating;
  final String comment;
  final DateTime createdAt;

  ProblemReview({
    required this.id,
    required this.problemId,
    required this.reviewerId,
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

class PlanRating {
  final String id;
  final String planId;
  final String raterId;
  final String raterName;
  final int rating;
  final String comment;
  final DateTime createdAt;

  PlanRating({
    required this.id,
    required this.planId,
    required this.raterId,
    required this.raterName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

class User {
  final String id;
  final String name;
  final DateTime joinDate;
  final int problemsPosted;
  final int plansSubmitted;
  final int reviewsGiven;

  User({
    required this.id,
    required this.name,
    required this.joinDate,
    this.problemsPosted = 0,
    this.plansSubmitted = 0,
    this.reviewsGiven = 0,
  });
}