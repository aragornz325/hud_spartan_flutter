import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hud/features/HudScreen/hud_screen.dart';
import 'package:hud/features/bootScreen/boot_screen.dart';
import 'package:hud/features/welcomeScreen/welcome_screen.dart';
import 'package:hud/l10n/l10n.dart';
import 'package:hud/providers/locale/locale_provider.dart';
import 'package:hud/theme/spartan_theme.dart';
import 'package:hud_spartan_client/hud_spartan_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Configuración del cliente de Serverpod
final client = Client('http://localhost:8080/')
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

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
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
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('it'),
        Locale('pt'),
      ],
      routerConfig: _router,
    );
  }
}
