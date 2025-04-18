import 'package:dio/dio.dart';
import '../../../session_cache.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //option
    if (SessionCache.token?.isNotEmpty ?? false) {
      options.headers['Authorization'] = "Bearer ${SessionCache.token}";
      //   options.headers['uid'] = SessionCache.token!.uid;
      //   options.headers['client'] = SessionCache.token!.client;
      //   if (SessionCache.deviceId != null) {
      //     options.headers['device-uid'] = SessionCache.deviceId;
      //   }
    }

    return handler.next(options);
  }
}
