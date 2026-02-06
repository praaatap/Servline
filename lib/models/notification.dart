import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as appwrite;

/// Notification type enum
enum NotificationType {
  turnApproaching,
  turnReady,
  queueUpdate,
  ticketCreated,
  ticketCancelled,
  general,
}

extension NotificationTypeExtension on NotificationType {
  String get value {
    switch (this) {
      case NotificationType.turnApproaching:
        return 'turn_approaching';
      case NotificationType.turnReady:
        return 'turn_ready';
      case NotificationType.queueUpdate:
        return 'queue_update';
      case NotificationType.ticketCreated:
        return 'ticket_created';
      case NotificationType.ticketCancelled:
        return 'ticket_cancelled';
      case NotificationType.general:
        return 'general';
    }
  }
  
  IconData get icon {
    switch (this) {
      case NotificationType.turnApproaching:
        return Icons.schedule;
      case NotificationType.turnReady:
        return Icons.notifications_active;
      case NotificationType.queueUpdate:
        return Icons.update;
      case NotificationType.ticketCreated:
        return Icons.confirmation_number;
      case NotificationType.ticketCancelled:
        return Icons.cancel;
      case NotificationType.general:
        return Icons.info_outline;
    }
  }
  
  Color get color {
    switch (this) {
      case NotificationType.turnApproaching:
        return const Color(0xFFF59E0B); // Warning/Amber
      case NotificationType.turnReady:
        return const Color(0xFF22C55E); // Success/Green
      case NotificationType.queueUpdate:
        return const Color(0xFF3B82F6); // Info/Blue
      case NotificationType.ticketCreated:
        return const Color(0xFF3B82F6); // Info/Blue
      case NotificationType.ticketCancelled:
        return const Color(0xFFEF4444); // Error/Red
      case NotificationType.general:
        return const Color(0xFF6B7280); // Gray
    }
  }
  
  static NotificationType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'turn_approaching':
        return NotificationType.turnApproaching;
      case 'turn_ready':
        return NotificationType.turnReady;
      case 'queue_update':
        return NotificationType.queueUpdate;
      case 'ticket_created':
        return NotificationType.ticketCreated;
      case 'ticket_cancelled':
        return NotificationType.ticketCancelled;
      default:
        return NotificationType.general;
    }
  }
}

/// Notification model
class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final NotificationType type;
  final bool isRead;
  final String? ticketId;
  final String? actionText;
  final String? actionRoute;
  final DateTime createdAt;
  
  const NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    this.ticketId,
    this.actionText,
    this.actionRoute,
    required this.createdAt,
  });
  
  /// Create NotificationModel from Appwrite Document
  factory NotificationModel.fromDocument(appwrite.Document doc) {
    return NotificationModel(
      id: doc.$id,
      userId: doc.data['userId'] ?? '',
      title: doc.data['title'] ?? '',
      message: doc.data['message'] ?? '',
      type: NotificationTypeExtension.fromString(doc.data['type'] ?? 'general'),
      isRead: doc.data['isRead'] ?? false,
      ticketId: doc.data['ticketId'],
      actionText: doc.data['actionText'],
      actionRoute: doc.data['actionRoute'],
      createdAt: DateTime.tryParse(doc.data['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
  
  /// Convert to JSON for Appwrite
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'message': message,
      'type': type.value,
      'isRead': isRead,
      'ticketId': ticketId,
      'actionText': actionText,
      'actionRoute': actionRoute,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  /// Copy with new values
  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    NotificationType? type,
    bool? isRead,
    String? ticketId,
    String? actionText,
    String? actionRoute,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      ticketId: ticketId ?? this.ticketId,
      actionText: actionText ?? this.actionText,
      actionRoute: actionRoute ?? this.actionRoute,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  /// Get relative time string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }
}
