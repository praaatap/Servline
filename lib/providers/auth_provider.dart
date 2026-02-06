import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String id;
  final String email;
  final String name;

  User({required this.id, required this.email, required this.name});
}

class AuthState {
  final bool isLoggedIn;
  final User? user;
  final bool isGuest;

  AuthState({this.isLoggedIn = false, this.user, this.isGuest = false});

  AuthState copyWith({bool? isLoggedIn, User? user, bool? isGuest}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

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

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
