import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class TicketNotifier extends StateNotifier<Ticket?> {
  TicketNotifier() : super(null);

  void createTicket(String locationId, String locationName) {
    // Mock creating a ticket
    state = Ticket(
      id: 'ticket_123',
      tokenNumber: 'A-42',
      locationId: locationId,
      locationName: locationName,
      currentQueuePosition: 3,
      estimatedWaitMinutes: 15,
      issuedAt: DateTime.now(),
    );
  }

  void cancelTicket() {
    state = null;
  }
}

final ticketProvider = StateNotifierProvider<TicketNotifier, Ticket?>((ref) {
  return TicketNotifier();
});
