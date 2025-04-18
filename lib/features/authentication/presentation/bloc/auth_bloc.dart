import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecase/get_auth_status.dart';
import '../../domain/usecase/log_out.dart';
import '../../domain/usecase/login_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String AUTH_FAILURE_MESSAGE = 'Authentication Failed';
const String UNEXPECTED_ERROR_MESSAGE = 'An unexpected error occurred';
@injectable // Or @factory
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final GetAuthStatus getAuthStatus;

  AuthBloc({
    required this.loginUser,
    required this.logoutUser,
    required this.getAuthStatus,
  }) : super(AuthInitial()) { // Start with Initial state
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading()); // Use const factory
    final failureOrUser = await getAuthStatus(NoParams());
    // Use generated map/when for cleaner state updates
    emit(failureOrUser.fold(
          (failure) => const AuthState.unauthenticated(), // Use const factory
          (user) => AuthState.authenticated(user: user), // Use factory
    ));
  }

// Example: _onLoginRequested
  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final failureOrUser = await loginUser(
      // Create freezed LoginParams instance
      LoginParams(email: event.email, password: event.password),
    );
    emit(failureOrUser.fold(
          (failure) => AuthState.error(message: _mapFailureToMessage(failure)),
          (user) => AuthState.authenticated(user: user),
    ));
  }

  // Example: _onLogoutRequested
  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final failureOrSuccess = await logoutUser(NoParams());
    emit(failureOrSuccess.fold(
          (failure) => AuthState.error(message: _mapFailureToMessage(failure)),
          (_) => const AuthState.unauthenticated(), // Use const factory
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message ?? SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return failure.message ?? CACHE_FAILURE_MESSAGE;
      case AuthenticationFailure:
        return failure.message ?? AUTH_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR_MESSAGE;
    }
  }
}
