import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable  {
  final String? message; // Optional message
  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.message});
}
class CacheFailure extends Failure {
  const CacheFailure({super.message});
}
class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message});
}
// Add other specific failures as needed