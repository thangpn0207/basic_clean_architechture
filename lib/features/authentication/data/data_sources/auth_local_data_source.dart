import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart'; // For caching user data if needed
import 'dart:convert'; // For encoding/decoding user map

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel userToCache); // Or just cacheToken(String token)
  Future<UserModel?> getLastUser(); // Or just getToken()
  Future<void> clearCache();
}

const CACHED_USER_KEY = 'CACHED_USER'; // Or CACHED_AUTH_TOKEN

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel userToCache) {
    // Storing the whole user object (including token) as JSON string
    return sharedPreferences.setString(
      CACHED_USER_KEY,
      json.encode(userToCache.toJson()), // Store as JSON string
    );
    // Alternatively, just store the token:
    // if (userToCache.token != null) {
    //   return sharedPreferences.setString(CACHED_AUTH_TOKEN, userToCache.token!);
    // } else {
    //   return Future.value(); // Or throw error if token is expected
    // }
  }

  @override
  Future<UserModel?> getLastUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER_KEY);
    if (jsonString != null) {
      try {
        return Future.value(UserModel.fromJson(json.decode(jsonString)));
      } catch (e) {
        // If parsing fails, treat as no cached user
        return Future.value(null);
      }
    } else {
      return Future.value(null);
    }
    // Alternatively, just retrieve token:
    // final token = sharedPreferences.getString(CACHED_AUTH_TOKEN);
    // return Future.value(token);
  }

  @override
  Future<void> clearCache() {
    return sharedPreferences.remove(CACHED_USER_KEY);
    // Alternatively: return sharedPreferences.remove(CACHED_AUTH_TOKEN);
  }
}