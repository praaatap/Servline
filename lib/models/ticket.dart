import 'package:appwrite/models.dart' as appwrite;

/// Ticket status enum
enum TicketStatus {
  waiting,
  called,
  serving,
  completed,
  cancelled,
  noShow,
  scheduled,
}

extension TicketStatusExtension on TicketStatus {
  String get displayName {
    switch (this) {
      case TicketStatus.waiting:
        return 'Waiting';
      case TicketStatus.called:
        return 'Called';
      case TicketStatus.serving:
        return 'Serving';
      case TicketStatus.completed:
        return 'Completed';
      case TicketStatus.cancelled:
        return 'Cancelled';
      case TicketStatus.noShow:
        return 'No Show';
      case TicketStatus.scheduled:
        return 'Scheduled';
    }
  }

  String get value {
    switch (this) {
      case TicketStatus.waiting:
        return 'waiting';
      case TicketStatus.called:
        return 'called';
      case TicketStatus.serving:
        return 'serving';
      case TicketStatus.completed:
        return 'completed';
      case TicketStatus.cancelled:
        return 'cancelled';
      case TicketStatus.noShow:
        return 'no_show';
      case TicketStatus.scheduled:
        return 'scheduled';
    }
  }

  static TicketStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'waiting':
        return TicketStatus.waiting;
      case 'called':
        return TicketStatus.called;
      case 'serving':
        return TicketStatus.serving;
      case 'completed':
        return TicketStatus.completed;
      case 'cancelled':
        return TicketStatus.cancelled;
      case 'no_show':
        return TicketStatus.noShow;
      case 'scheduled':
        return TicketStatus.scheduled;
      default:
        return TicketStatus.waiting;
    }
  }
}

/// Ticket model with Appwrite serialization
class Ticket {
  final String id;
  final String tokenNumber;
  final String userId;
  final String locationId;
  final String locationName;
  final String serviceId;
  final String serviceName;
  final String? counterNumber;
  final int headCount;
  final int currentQueuePosition;
  final int totalInQueue;
  final int estimatedWaitMinutes;
  final TicketStatus status;
  final DateTime issuedAt;
  final DateTime? calledAt;
  final DateTime? completedAt;
  final DateTime? scheduledTime; // For appointments
  final bool notifyBySms;

  const Ticket({
    required this.id,
    required this.tokenNumber,
    required this.userId,
    required this.locationId,
    required this.locationName,
    required this.serviceId,
    required this.serviceName,
    this.counterNumber,
    this.headCount = 1,
    required this.currentQueuePosition,
    this.totalInQueue = 0,
    required this.estimatedWaitMinutes,
    this.status = TicketStatus.waiting,
    required this.issuedAt,
    this.calledAt,
    this.completedAt,
    this.scheduledTime,
    this.notifyBySms = false,
  });

  /// Create Ticket from Appwrite Document
  factory Ticket.fromDocument(appwrite.Document doc) {
    return Ticket(
      id: doc.$id,
      tokenNumber: doc.data['tokenNumber'] ?? '',
      userId: doc.data['userId'] ?? '',
      locationId: doc.data['locationId'] ?? '',
      locationName: doc.data['locationName'] ?? '',
      serviceId: doc.data['serviceId'] ?? '',
      serviceName: doc.data['serviceName'] ?? '',
      counterNumber: doc.data['counterNumber'],
      headCount: doc.data['headCount'] ?? 1,
      currentQueuePosition: doc.data['currentQueuePosition'] ?? 0,
      totalInQueue: doc.data['totalInQueue'] ?? 0,
      estimatedWaitMinutes: doc.data['estimatedWaitMinutes'] ?? 0,
      status: TicketStatusExtension.fromString(doc.data['status'] ?? 'waiting'),
      issuedAt: DateTime.tryParse(doc.data['issuedAt'] ?? '') ?? DateTime.now(),
      calledAt: doc.data['calledAt'] != null
          ? DateTime.tryParse(doc.data['calledAt'])
          : null,
      completedAt: doc.data['completedAt'] != null
          ? DateTime.tryParse(doc.data['completedAt'])
          : null,
      scheduledTime: doc.data['scheduledTime'] != null
          ? DateTime.tryParse(doc.data['scheduledTime'])
          : null,
      notifyBySms: doc.data['notifyBySms'] ?? false,
    );
  }

  /// Convert to JSON for Appwrite
  Map<String, dynamic> toJson() {
    return {
      'tokenNumber': tokenNumber,
      'userId': userId,
      'locationId': locationId,
      'locationName': locationName,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'counterNumber': counterNumber,
      'headCount': headCount,
      'currentQueuePosition': currentQueuePosition,
      'totalInQueue': totalInQueue,
      'estimatedWaitMinutes': estimatedWaitMinutes,
      'status': status.value,
      'issuedAt': issuedAt.toIso8601String(),
      'calledAt': calledAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'scheduledTime': scheduledTime?.toIso8601String(),
      'notifyBySms': notifyBySms,
    };
  }

  /// Copy with new values
  Ticket copyWith({
    String? id,
    String? tokenNumber,
    String? userId,
    String? locationId,
    String? locationName,
    String? serviceId,
    String? serviceName,
    String? counterNumber,
    int? headCount,
    int? currentQueuePosition,
    int? totalInQueue,
    int? estimatedWaitMinutes,
    TicketStatus? status,
    DateTime? issuedAt,
    DateTime? calledAt,
    DateTime? completedAt,
    DateTime? scheduledTime,
    bool? notifyBySms,
  }) {
    return Ticket(
      id: id ?? this.id,
      tokenNumber: tokenNumber ?? this.tokenNumber,
      userId: userId ?? this.userId,
      locationId: locationId ?? this.locationId,
      locationName: locationName ?? this.locationName,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      counterNumber: counterNumber ?? this.counterNumber,
      headCount: headCount ?? this.headCount,
      currentQueuePosition: currentQueuePosition ?? this.currentQueuePosition,
      totalInQueue: totalInQueue ?? this.totalInQueue,
      estimatedWaitMinutes: estimatedWaitMinutes ?? this.estimatedWaitMinutes,
      status: status ?? this.status,
      issuedAt: issuedAt ?? this.issuedAt,
      calledAt: calledAt ?? this.calledAt,
      completedAt: completedAt ?? this.completedAt,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      notifyBySms: notifyBySms ?? this.notifyBySms,
    );
  }

  /// Calculate queue progress (0.0 - 1.0)
  double get queueProgress {
    if (totalInQueue == 0) return 0.0;
    final completed = totalInQueue - currentQueuePosition;
    return (completed / totalInQueue).clamp(0.0, 1.0);
  }

  /// Check if ticket is active (in regular queue)
  bool get isActive =>
      status == TicketStatus.waiting ||
      status == TicketStatus.called ||
      status == TicketStatus.serving;

  /// Check if ticket is a scheduled appointment
  bool get isAppointment => status == TicketStatus.scheduled;
}
