import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:servline/models/auth_state.dart';
import 'package:servline/models/user.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  void login(String email, String password) {
    // Simulate API call
    state = state.copyWith(
      isLoggedIn: true,
      user: User(id: '1', email: email, name: 'John Doe'),
      isGuest: false,
    );
  }

  void loginAsGuest() {
    state = state.copyWith(
      isLoggedIn: true,
      isGuest: true,
      user: User(
        id: 'guest',
        email: 'guest@silentqueue.com',
        name: 'Guest User',
      ),
    );
  }

  void logout() {
    state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
