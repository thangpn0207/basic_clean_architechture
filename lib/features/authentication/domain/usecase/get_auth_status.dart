import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
@lazySingleton // Use cases are typically stateless singletons
class GetAuthStatus implements UseCase<User, NoParams> {
  final AuthRepository repository;

  GetAuthStatus(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getAuthStatus();
  }
}