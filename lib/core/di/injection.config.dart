// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/authentication/data/data_sources/auth_local_data_source.dart'
    as _i900;
import '../../features/authentication/data/data_sources/auth_remote_data_source.dart'
    as _i742;
import '../../features/authentication/data/repositories/auth_repository_impl.dart'
    as _i317;
import '../../features/authentication/domain/repositories/auth_repository.dart'
    as _i742;
import '../../features/authentication/domain/usecase/get_auth_status.dart'
    as _i415;
import '../../features/authentication/domain/usecase/log_out.dart' as _i1058;
import '../../features/authentication/domain/usecase/login_user.dart' as _i603;
import '../../features/authentication/presentation/bloc/auth_bloc.dart'
    as _i180;
import 'register_module.dart' as _i291;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
  await gh.lazySingletonAsync<_i460.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i742.AuthRemoteDataSource>(
    () => _i742.AuthRemoteDataSourceImpl(dioClient: gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i900.AuthLocalDataSource>(
    () => _i900.AuthLocalDataSourceImpl(
      sharedPreferences: gh<_i460.SharedPreferences>(),
    ),
  );
  gh.lazySingleton<_i742.AuthRepository>(
    () => _i317.AuthRepositoryImpl(
      remoteDataSource: gh<_i742.AuthRemoteDataSource>(),
      localDataSource: gh<_i900.AuthLocalDataSource>(),
    ),
  );
  gh.lazySingleton<_i1058.LogoutUser>(
    () => _i1058.LogoutUser(gh<_i742.AuthRepository>()),
  );
  gh.lazySingleton<_i603.LoginUser>(
    () => _i603.LoginUser(gh<_i742.AuthRepository>()),
  );
  gh.lazySingleton<_i415.GetAuthStatus>(
    () => _i415.GetAuthStatus(gh<_i742.AuthRepository>()),
  );
  gh.factory<_i180.AuthBloc>(
    () => _i180.AuthBloc(
      loginUser: gh<_i603.LoginUser>(),
      logoutUser: gh<_i1058.LogoutUser>(),
      getAuthStatus: gh<_i415.GetAuthStatus>(),
    ),
  );
  return getIt;
}

class _$RegisterModule extends _i291.RegisterModule {}
