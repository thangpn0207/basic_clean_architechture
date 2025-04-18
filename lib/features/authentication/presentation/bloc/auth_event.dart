import 'package:freezed_annotation/freezed_annotation.dart';
// Remove equatable import if no longer needed elsewhere in the file

part 'auth_event.freezed.dart'; // Generated file

@freezed
abstract class AuthEvent with _$AuthEvent {
  // Event dispatched on app start
  const factory AuthEvent.checkStatus() = CheckAuthStatus;

  // Event dispatched when user clicks login button
  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = LoginRequested;

  // Event dispatched when user clicks logout button
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
// Remove the old abstract class AuthEvent and individual event classes