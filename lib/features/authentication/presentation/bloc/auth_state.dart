import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart'; // Import the freezed User entity
// Remove equatable import
part 'auth_state.freezed.dart'; // Generated file

@freezed
abstract class AuthState with _$AuthState {
  // Initial state before checking status
  const factory AuthState.initial() = AuthInitial;

  // State while checking status or logging in/out
  const factory AuthState.loading() = AuthLoading;

  // State when user is successfully authenticated
  const factory AuthState.authenticated({required User user}) = Authenticated;

  // State when user is not authenticated
  const factory AuthState.unauthenticated() = Unauthenticated;

  // State when an error occurs
  const factory AuthState.error({required String message}) = AuthError;
}
// Remove the old abstract class AuthState and individual state classes