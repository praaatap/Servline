import 'package:appwrite/models.dart' as appwrite;

/// Feedback model for service ratings
class FeedbackModel {
  final String id;
  final String userId;
  final String ticketId;
  final String locationId;
  final int rating; // 1-5
  final String? notes;
  final List<String> tags;
  final DateTime createdAt;
  
  const FeedbackModel({
    required this.id,
    required this.userId,
    required this.ticketId,
    required this.locationId,
    required this.rating,
    this.notes,
    this.tags = const [],
    required this.createdAt,
  });
  
  /// Create FeedbackModel from Appwrite Document
  factory FeedbackModel.fromDocument(appwrite.Document doc) {
    return FeedbackModel(
      id: doc.$id,
      userId: doc.data['userId'] ?? '',
      ticketId: doc.data['ticketId'] ?? '',
      locationId: doc.data['locationId'] ?? '',
      rating: doc.data['rating'] ?? 3,
      notes: doc.data['notes'],
      tags: List<String>.from(doc.data['tags'] ?? []),
      createdAt: DateTime.tryParse(doc.data['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
  
  /// Convert to JSON for Appwrite
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'ticketId': ticketId,
      'locationId': locationId,
      'rating': rating,
      'notes': notes,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  /// Get rating label
  String get ratingLabel {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Okay';
      case 4:
        return 'Good';
      case 5:
        return 'Excellent';
      default:
        return 'Unknown';
    }
  }
  
  /// Get rating emoji
  String get ratingEmoji {
    switch (rating) {
      case 1:
        return '😠';
      case 2:
        return '😕';
      case 3:
        return '😐';
      case 4:
        return '🙂';
      case 5:
        return '😄';
      default:
        return '😐';
    }
  }
}

/// Common feedback tags
class FeedbackTags {
  static const String cleanEnvironment = 'Clean environment';
  static const String friendlyStaff = 'Friendly staff';
  static const String fastService = 'Fast service';
  static const String quietAtmosphere = 'Quiet atmosphere';
  static const String longWait = 'Long wait';
  static const String poorService = 'Poor service';
  static const String uncomfortable = 'Uncomfortable';
  static const String confusing = 'Confusing';
  
  static List<String> get positiveTags => [
    cleanEnvironment,
    friendlyStaff,
    fastService,
    quietAtmosphere,
  ];
  
  static List<String> get negativeTags => [
    longWait,
    poorService,
    uncomfortable,
    confusing,
  ];
  
  static List<String> get allTags => [...positiveTags, ...negativeTags];
}
