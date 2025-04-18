import 'package:base_clean_architechture/features/authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
@LazySingleton(as: AuthRepository) // Implement AuthRepository interface
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final remoteUser = await remoteDataSource.login(email, password);
      // Cache the user/token upon successful login
      await localDataSource.cacheUser(remoteUser);
      return Right(remoteUser.toDomain()); // remoteUser is already a User (due to UserModel extends User)
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "An unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Attempt remote logout first (if applicable) - ignore errors for simplicity maybe
      try {
        await remoteDataSource.logout();
      } catch (_) {
        // Log this maybe, but don't block local logout
        print("Remote logout failed, proceeding with local.");
      }
      // Always clear local cache
      await localDataSource.clearCache();
      return const Right(null); // Use `Right(null)` for void success
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "An unexpected error during logout"));
    }
  }

  @override
  Future<Either<Failure, User>> getAuthStatus() async {
    try {
      final cachedUser = await localDataSource.getLastUser();
      if (cachedUser != null && cachedUser.token != null) {
        // Simple check: if user/token is cached, assume authenticated
        // A real app might verify the token with the backend here
        return Right(cachedUser.toDomain());
      } else {
        return Left(AuthenticationFailure(message: 'Not authenticated'));
      }
    } on CacheException catch(e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to read auth status'));
    }
  }
}