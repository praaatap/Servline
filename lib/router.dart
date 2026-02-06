import 'package:go_router/go_router.dart';
import 'package:servline/screens/auth/login_screen.dart';
import 'package:servline/screens/feedback/feedback_screen.dart';
import 'package:servline/screens/home/home_screen.dart';
import 'package:servline/screens/history/visit_history_screen.dart';
import 'package:servline/screens/location/nearby_locations_screen.dart';
import 'package:servline/screens/notifications/notifications_screen.dart';
import 'package:servline/screens/onboarding/how_it_works_screen.dart';
import 'package:servline/screens/onboarding/location_access_screen.dart';
import 'package:servline/screens/onboarding/notification_access_screen.dart';
import 'package:servline/screens/onboarding/welcome_intro_screen.dart';
import 'package:servline/screens/service/select_service_screen.dart';
import 'package:servline/screens/settings/settings_screen.dart';
import 'package:servline/screens/support/help_center_screen.dart';
import 'package:servline/screens/splash_screen.dart';
import 'package:servline/screens/ticket/active_ticket_screen.dart';
import 'package:servline/screens/ticket/your_turn_screen.dart';
import 'package:servline/screens/qr/qr_scanner_screen.dart';
import 'package:servline/screens/appointment/schedule_appointment_screen.dart';

import 'package:servline/providers/ticket_provider.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/intro',
      builder: (context, state) => const WelcomeIntroScreen(),
    ),
    GoRoute(
      path: '/how-it-works',
      builder: (context, state) => const HowItWorksScreen(),
    ),
    GoRoute(
      path: '/notification-access',
      builder: (context, state) => const NotificationAccessScreen(),
    ),
    GoRoute(
      path: '/location-access',
      builder: (context, state) => const LocationAccessScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/active-ticket',
      builder: (context, state) => const ActiveTicketScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const VisitHistoryScreen(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpCenterScreen(),
    ),
    GoRoute(
      path: '/nearby',
      builder: (context, state) => const NearbyLocationsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    // New routes for Appwrite integration
    GoRoute(
      path: '/scan-qr',
      builder: (context, state) => const QRScannerScreen(),
    ),
    GoRoute(
      path: '/select-service/:locationId',
      builder: (context, state) {
        final locationId = state.pathParameters['locationId'] ?? '';
        return SelectServiceScreen(locationId: locationId);
      },
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/feedback/:ticketId/:locationId',
      builder: (context, state) {
        final ticketId = state.pathParameters['ticketId'] ?? '';
        final locationId = state.pathParameters['locationId'] ?? '';
        return FeedbackScreen(ticketId: ticketId, locationId: locationId);
      },
    ),
    GoRoute(
      path: '/your-turn',
      builder: (context, state) => const YourTurnScreen(),
    ),
    GoRoute(
      path:
          '/schedule-appointment/:locationId/:locationName/:serviceId/:serviceName',
      builder: (context, state) {
        final locationId = state.pathParameters['locationId'] ?? '';
        final locationName = state.pathParameters['locationName'] ?? '';
        final serviceId = state.pathParameters['serviceId'] ?? '';
        final serviceName = state.pathParameters['serviceName'] ?? '';
        return ScheduleAppointmentScreen(
          locationId: locationId,
          locationName: locationName,
          serviceId: serviceId,
          serviceName: serviceName,
        );
      },
    ),
  ],
);
