import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../funciones/auth/pantallas/login_screen.dart';
import '../funciones/auth/pantallas/signup_screen.dart';
import '../funciones/auth/pantallas/forgot_password_screen.dart';
import '../funciones/pedidos/pantallas/home_screen.dart';
import '../funciones/pedidos/pantallas/details_screen.dart';

// Create the router
final goRouterProvider = Provider<GoRouter>((ref) {
  final authStateAsync = ref.watch(currentUserProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn =
          authStateAsync.whenData((user) => user != null).value ?? false;
      final isAuthRoute = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/signup') ||
          state.matchedLocation.startsWith('/forgot-password');

      // Si no está logueado y no está en una ruta de auth, ir a login
      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      // Si está logueado y está en ruta de auth, ir a home
      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/details',
        name: 'details',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return DetailsScreen(
            nombre: extra?['nombre'] ?? 'Item',
            precio: extra?['precio'] ?? 0.0,
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text('Ruta no encontrada: ${state.error}'),
      ),
    ),
  );
});
