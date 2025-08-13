import '../entities/review.dart';

abstract class ReviewRepository {
  // Fetch reviews
  Future<List<Review>> getAllReviews();
  Future<Review?> getReviewById(String id);
  Future<List<Review>> getReviewsByStore(String storeId);
  Future<List<Review>> getReviewsByUser(String userId);
  Future<List<Review>> getReviewsByOrder(String orderId);
  Future<List<Review>> getReviewsByRating(int rating);
  Future<List<Review>> getVerifiedReviews();
  Future<List<Review>> getHiddenReviews();
  Future<List<Review>> getReviewsWithImages();
  Future<List<Review>> getReviewsWithOwnerResponse();
  Future<List<Review>> getRecentReviews({int limit = 10});
  Future<List<Review>> getTopRatedReviews({int limit = 10});
  Future<List<Review>> getReportedReviews();

  // Search reviews
  Future<List<Review>> searchReviews(String query);
  Future<List<Review>> searchReviewsByStore(String storeId, String query);

  // Create and update reviews
  Future<Review> createReview(Review review);
  Future<Review> updateReview(Review review);
  Future<Review> updateReviewRating(String id, int rating);
  Future<Review> updateReviewComment(String id, String comment);
  Future<Review> updateReviewImages(String id, List<String> imageUrls);
  Future<Review> verifyReview(String id);
  Future<Review> hideReview(String id);
  Future<Review> showReview(String id);
  Future<Review> addOwnerResponse(String id, String response);
  Future<Review> updateOwnerResponse(String id, String response);
  Future<Review> removeOwnerResponse(String id);

  // Review interactions
  Future<Review> likeReview(String id, String userId);
  Future<Review> unlikeReview(String id, String userId);
  Future<Review> reportReview(String id, String userId, String reason);
  Future<Review> unreportReview(String id, String userId);

  // Delete reviews
  Future<void> deleteReview(String id);
  Future<void> softDeleteReview(String id);
  Future<void> restoreReview(String id);

  // Review statistics
  Future<ReviewStats?> getReviewStatsByStore(String storeId);
  Future<Map<String, dynamic>> getReviewCounts();
  Future<Map<String, dynamic>> getReviewCountsByStore(String storeId);
  Future<Map<String, dynamic>> getReviewCountsByUser(String userId);
  Future<double> getAverageRatingByStore(String storeId);
  Future<double> getOverallAverageRating();
  Future<int> getTotalReviewCount();
  Future<int> getVerifiedReviewCount();
  Future<int> getReviewCountByRating(int rating);
  Future<Map<int, int>> getRatingDistribution();
  Future<Map<int, int>> getRatingDistributionByStore(String storeId);

  // Review analytics
  Future<List<Review>> getMostLikedReviews({int limit = 10});
  Future<List<Review>> getMostReportedReviews({int limit = 10});
  Future<Map<String, dynamic>> getReviewTrends();
  Future<Map<String, dynamic>> getMonthlyReviewStats();
  Future<List<String>> getTopReviewedStores({int limit = 10});
  Future<List<String>> getMostActiveReviewers({int limit = 10});

  // Bulk operations
  Future<void> bulkVerifyReviews(List<String> reviewIds);
  Future<void> bulkHideReviews(List<String> reviewIds);
  Future<void> bulkDeleteReviews(List<String> reviewIds);
  Future<void> bulkRestoreReviews(List<String> reviewIds);

  // Review validation
  Future<bool> canUserReviewStore(String userId, String storeId);
  Future<bool> hasUserReviewedOrder(String userId, String orderId);
  Future<bool> isReviewEditable(String reviewId, String userId);
  Future<bool> isReviewDeletable(String reviewId, String userId);

  // Review moderation
  Future<List<Review>> getPendingModerationReviews();
  Future<Review> approveReview(String id);
  Future<Review> rejectReview(String id, String reason);
  Future<void> flagInappropriateContent(String id);
  Future<void> unflagContent(String id);

  // Review notifications
  Future<void> notifyStoreOwnerOfNewReview(String reviewId);
  Future<void> notifyUserOfOwnerResponse(String reviewId);
  Future<void> notifyUserOfReviewLike(String reviewId, String likerUserId);

  // Review export
  Future<List<Review>> exportStoreReviews(String storeId);
  Future<List<Review>> exportUserReviews(String userId);
  Future<Map<String, dynamic>> generateReviewReport(String storeId);
}

abstract class ReviewStatsRepository {
  // Fetch review stats
  Future<ReviewStats?> getStatsByStore(String storeId);
  Future<List<ReviewStats>> getAllStats();
  Future<List<ReviewStats>> getStatsForStores(List<String> storeIds);

  // Create and update stats
  Future<ReviewStats> createStats(ReviewStats stats);
  Future<ReviewStats> updateStats(ReviewStats stats);
  Future<ReviewStats> recalculateStats(String storeId);
  Future<void> updateStatsAfterReview(String storeId, Review review);
  Future<void> updateStatsAfterReviewUpdate(String storeId, Review oldReview, Review newReview);
  Future<void> updateStatsAfterReviewDeletion(String storeId, Review review);

  // Bulk operations
  Future<void> recalculateAllStats();
  Future<void> updateMultipleStats(List<ReviewStats> statsList);

  // Stats analytics
  Future<List<ReviewStats>> getTopRatedStores({int limit = 10});
  Future<List<ReviewStats>> getMostReviewedStores({int limit = 10});
  Future<Map<String, dynamic>> getOverallStats();
  Future<double> getAverageRatingAcrossAllStores();
  Future<int> getTotalReviewsAcrossAllStores();

  // Delete stats
  Future<void> deleteStats(String storeId);
  Future<void> softDeleteStats(String storeId);
  Future<void> restoreStats(String storeId);
}