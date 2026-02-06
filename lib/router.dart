import 'package:go_router/go_router.dart';
import 'package:servline/screens/auth/login_screen.dart';
import 'package:servline/screens/home/home_screen.dart'; // Will create this next
import 'package:servline/screens/onboarding/how_it_works_screen.dart';
import 'package:servline/screens/onboarding/location_access_screen.dart';
import 'package:servline/screens/onboarding/notification_access_screen.dart';
import 'package:servline/screens/onboarding/welcome_intro_screen.dart';
import 'package:servline/screens/splash_screen.dart';

final router = GoRouter(
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
  ],
);
