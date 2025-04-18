import 'package:base_clean_architechture/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/authentication/presentation/bloc/auth_state.dart';
import '../../features/home/presentation/pages/home_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
class AppRoutes {
  static const home = '/home';
  static const login = '/login';
}
class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: true,

    // Disable GoRouter transitions
    routerNeglect: true,

    // Define routes without transitions for better web performance
    routes: [
      // Home route
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),

      // Login route
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      )
    ],

    // Error page without transitions
    // errorPageBuilder: (context, state) => Scaffold(
    //   appBar: AppBar(title: const Text('Page Not Found')),
    //   body: Center(
    //     child: Text('No route found for ${state.uri.path}'),
    //   ),
    // ),

    // Redirect logic
    redirect: (context, state) {
      // Example: check authentication and redirect if needed
      final isAuthenticated = context.read<AuthBloc>().state is Authenticated;
      if (!isAuthenticated &&
          ![AppRoutes.login].contains(state.path)) {
        return AppRoutes.login;
      }
      return null; // No redirect
    },
  );
}
