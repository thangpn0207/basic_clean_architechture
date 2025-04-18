// lib/core/di/register_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/config_networks/config_networks.dart';
import '../network/interceptors/error_interceptor.dart';
import '../network/interceptors/token_interceptor.dart';

@module // Annotate as a module
abstract class RegisterModule {

  @lazySingleton // Register Dio as a lazy singleton
  Dio get dio { // Provide the Dio instance
    // Configure Dio instance (Base URL, Interceptors, Timeouts etc.)
    final dio = Dio(BaseOptions(baseUrl: '',   receiveTimeout:
    const Duration(milliseconds: ConfigNetwork.receiveTimeout),
      connectTimeout:
      const Duration(milliseconds: ConfigNetwork.connectTimeout),),
    );
    dio.interceptors.addAll({
      //logging interceptor
      TokenInterceptor(),
      //error interceptor
      ErrorInterceptor(),
    });
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        compact: false,
        maxWidth: 120,
      ),
    );    return dio;
  }

  // Register SharedPreferences as an asynchronous lazy singleton
  @preResolve // Tells injectable to await this Future before finishing registration
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

// Add other third-party registrations here if needed
}