import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:servline/models/ticket.dart';

class TicketNotifier extends Notifier<Ticket?> {
  @override
  Ticket? build() {
    return null;
  }

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

final ticketProvider = NotifierProvider<TicketNotifier, Ticket?>(
  TicketNotifier.new,
);
