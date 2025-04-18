import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart'; // Assuming you have Failure types in core
import '../entities/user.dart';


abstract class AuthRepository {
  // Returns User on success, Failure on error
  Future<Either<Failure, User>> login(String email, String password);

  // Returns void on success, Failure on error
  Future<Either<Failure, void>> logout();

  // Optional: Check if user is currently logged in (e.g., check stored token)
  Future<Either<Failure, User>> getAuthStatus();
}