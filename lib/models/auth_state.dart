import 'package:servline/models/user.dart';

/// Authentication state model
class AuthState {
  final bool isLoggedIn;
  final User? user;
  final bool isGuest;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isLoggedIn = false,
    this.user,
    this.isGuest = false,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    User? user,
    bool? isGuest,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      isGuest: isGuest ?? this.isGuest,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Initial state
  factory AuthState.initial() => const AuthState();

  /// Loading state
  factory AuthState.loading() => const AuthState(isLoading: true);

  /// Authenticated state
  factory AuthState.authenticated(User user) =>
      AuthState(isLoggedIn: true, user: user, isGuest: user.isGuest);

  /// Error state
  factory AuthState.error(String message) => AuthState(error: message);
}
