import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart'; // Make sure this is imported
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

// --->>> Make sure this line is present and the filename is correct
part 'login_user.freezed.dart';
@lazySingleton // Use cases are typically stateless singletons
class LoginUser implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

// --->>> Ensure your LoginParams class looks like this:
@freezed // Annotation is present
class LoginParams with _$LoginParams { // 'with' the generated mixin
  @override
  final String email;

  @override
  final String  password;

  LoginParams({required this.email, required this.password});

}