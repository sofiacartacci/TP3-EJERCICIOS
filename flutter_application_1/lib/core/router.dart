import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen.dart';
import '../entities/destino.dart';
import '../screens/settings_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        final username = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(username: username),
        );
      case '/detail':
        final destino = settings.arguments as Destino;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(destino: destino),
        );
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No hay ruta definida para ${settings.name}'),
            ),
          ),
        );
    }
  }
}