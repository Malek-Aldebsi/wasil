import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: userCredential.user,
      ));
    } on FirebaseAuthException catch (e) {
      final msg = _mapFirebaseError(e);
      emit(state.copyWith(status: AuthStatus.error, error: msg));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error,
          error: 'An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: userCredential.user,
      ));
    } on FirebaseAuthException catch (e) {
      final msg = _mapFirebaseError(e);
      emit(state.copyWith(status: AuthStatus.error, error: msg));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error,
          error: 'An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  void checkAuth() {
    final user = _auth.currentUser;
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } else {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  // Convert Firebase codes to user‐friendly strings
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled. Contact support.';
      case 'user-not-found':
        return 'No account found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'That email is already registered.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger one.';
      case 'invalid-credential':
        return 'The email address or password you entered is incorrect, or the account doesn’t exist.';
      case 'channel-error':
        return 'Please check your network and try again.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
