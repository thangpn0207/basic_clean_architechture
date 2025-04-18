import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../authentication/presentation/bloc/auth_event.dart';
import '../../../authentication/presentation/bloc/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Dispatch logout event
              context.read<AuthBloc>().add(LogoutRequested());
              context.go(AppRoutes.login); // Navigate to login page
            },
          )
        ],
      ),
      body: Center(
        // You can display user info using BlocBuilder again if needed
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Text('Welcome, ${state.user.email}!');
            }
            return const Text('Welcome!'); // Fallback
          },
        ),
      ),
    );
  }
}