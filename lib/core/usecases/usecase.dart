import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

// Base class for UseCases with parameters
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Use this class for UseCases that don't accept any parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}