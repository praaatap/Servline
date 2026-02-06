class Ticket {
  final String id;
  final String tokenNumber;
  final String locationId;
  final String locationName;
  final int currentQueuePosition;
  final int estimatedWaitMinutes;
  final DateTime issuedAt;

  Ticket({
    required this.id,
    required this.tokenNumber,
    required this.locationId,
    required this.locationName,
    required this.currentQueuePosition,
    required this.estimatedWaitMinutes,
    required this.issuedAt,
  });
}
