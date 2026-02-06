import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:servline/core/config/appwrite_config.dart';
import 'package:servline/core/services/appwrite_service.dart';
import 'package:servline/models/feedback.dart';

/// Feedback Repository - handles feedback operations with Appwrite
class FeedbackRepository {
  final Databases _databases;

  FeedbackRepository(this._databases);

  /// Submit feedback for a completed ticket
  Future<FeedbackModel> submitFeedback({
    required String userId,
    required String ticketId,
    required String locationId,
    required int rating,
    String? notes,
    List<String> tags = const [],
  }) async {
    try {
      final result = await _databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.feedbackCollection,
        documentId: ID.unique(),
        data: {
          'userId': userId,
          'ticketId': ticketId,
          'locationId': locationId,
          'rating': rating,
          'notes': notes,
          'tags': tags,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      return FeedbackModel.fromDocument(result);
    } on AppwriteException catch (e) {
      throw 'Failed to submit feedback: ${e.message}';
    }
  }

  /// Get feedback for a ticket (check if already submitted)
  Future<FeedbackModel?> getFeedbackForTicket(String ticketId) async {
    try {
      final result = await _databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.feedbackCollection,
        queries: [Query.equal('ticketId', ticketId), Query.limit(1)],
      );

      if (result.documents.isEmpty) return null;
      return FeedbackModel.fromDocument(result.documents.first);
    } on AppwriteException catch (e) {
      throw 'Failed to get feedback: ${e.message}';
    }
  }

  /// Get all feedback by user
  Future<List<FeedbackModel>> getUserFeedback(String userId) async {
    try {
      final result = await _databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.feedbackCollection,
        queries: [Query.equal('userId', userId), Query.orderDesc('createdAt')],
      );

      return result.documents
          .map((doc) => FeedbackModel.fromDocument(doc))
          .toList();
    } on AppwriteException catch (e) {
      throw 'Failed to get user feedback: ${e.message}';
    }
  }
}

/// Provider for FeedbackRepository
final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  final databases = ref.watch(appwriteDatabasesProvider);
  return FeedbackRepository(databases);
});
