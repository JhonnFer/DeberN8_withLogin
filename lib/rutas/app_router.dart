import 'package:flutter/material.dart';
import '../funciones/pedidos/pantallas/home_screen.dart';
import '../funciones/pedidos/pantallas/details_screen.dart';


class AppRouter {
static const String home = '/';
static const String details = '/details';


static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
switch (settings.name) {
case home:
return MaterialPageRoute(builder: (_) => const HomeScreen());
case details:
final args = settings.arguments as Map<String, dynamic>?;
return MaterialPageRoute(
builder: (_) => DetailsScreen(
nombre: args?['nombre'] ?? 'Item',
precio: args?['precio'] ?? 0.0,
),
);
default:
return MaterialPageRoute(builder: (_) => const HomeScreen());
}
}
}