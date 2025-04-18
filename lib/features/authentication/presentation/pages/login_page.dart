import 'package:base_clean_architechture/core/routes/app_router.dart';
import 'package:base_clean_architechture/features/authentication/presentation/pages/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';


class LoginPage extends StatelessWidget {


  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is Authenticated) {
              context.go(AppRoutes.home); // Navigate to home page on successful login
            }
          },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Container(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(child: LoginForm(isLoading: isLoading)));
          // Use 'when' for exhaustive checking and cleaner UI logic
        },
      ),
    );
  }
}