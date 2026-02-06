import 'package:servline/models/user.dart';

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
