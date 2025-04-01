import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hud_spartan_flutter/features/HudScreen/hud_screen.dart';
import 'package:hud_spartan_flutter/features/bootScreen/boot_screen.dart';
import 'package:hud_spartan_flutter/features/welcomeScreen/welcome_screen.dart';
import 'package:hud_spartan_flutter/theme/spartan_theme.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:hud_spartan_client/hud_spartan_client.dart';

// Configuración del cliente de Serverpod
var client = Client('http://$localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

// GoRouter para navegación
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/hud',
      builder: (context, state) => const HudScreen(),
    ),
    GoRoute(
      path: '/boot',
      builder: (context, state) => const BootScreen(),
    ),
  ],
);

void main() {
  runApp(const SpartanHUDApp());
}

class SpartanHUDApp extends StatelessWidget {
  const SpartanHUDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Spartan HUD',
      theme: ThemeData(
        scaffoldBackgroundColor: SpartanColors.background,
        fontFamily: 'JetBrainsMono',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}
