import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart'; // You'll need ServerException defined in core
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> logout(); // Optional: If your API has a logout endpoint
}
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      // // --- Adjust Endpoint and Payload ---
      // final response = await dioClient.post(
      //   '/auth/login', // Replace with your actual login endpoint
      //   data: {
      //     'email': email,
      //     'password': password,
      //   },
      // );
      // // --- Adjust Status Code and Response Parsing ---
      // if (response.statusCode == 200) {
      //   // Assuming the API returns the user object directly in the data
      //   return UserModel.fromJson(response.data);
      // } else {
      //   // Handle specific API error responses if needed
      //   throw ServerException('Login failed: Status code ${response.statusCode}');
      // }
      if(email=="admin@its.com" && password=="admin"){
        return UserModel.fromJson({
          "id": "1",
          "name": "Admin",
          "email": email,
          "token": "admin_token",
        });
      } else {
        // Handle specific API error responses if needed
        throw ServerException('Login failed: Status code 500');
      }
    } on DioException catch (e) {
      // Handle Dio specific errors (network, timeout, etc.)
      throw ServerException(e.message ?? 'Network error during login');
    } catch (e) {
      throw ServerException('An unexpected error occurred during login');
    }
  }

  @override
  Future<void> logout() async {
    // Optional: Call API logout endpoint if it exists
    // Example: await dioClient.post('/auth/logout');
    // Usually, logout primarily involves clearing local token/data.
    // This might not need to throw an exception unless the API call fails critically.
    print("Remote Logout called (if API endpoint exists)");
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network
    return;
  }
}