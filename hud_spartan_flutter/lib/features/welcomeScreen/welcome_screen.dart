import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hud/l10n/l10n.dart';
import 'package:hud/providers/locale/locale_provider.dart';
import 'package:hud/widgets/text/spartan_pulsing_text.dart';
import 'package:hud/widgets/text/terminal_text.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);
    final t = context.l10n;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (selectedLocale != null) {
            context.go('/boot');
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SOLO mostramos esto si el idioma ya fue elegido
                if (selectedLocale != null) ...[
                  Column(
                    children: [
                      TerminalText(
                          text: '${t.thankYouForVisitingMySite}\n\n'
                              '${t.youreAboutFullyInteractivePortfolio},\n'
                              '${t.designedEmulateSpartanHUDHaloUniverse}\n\n'),
                      const SizedBox(height: 20),
                      TerminalText(
                        text: '${t.engageExploreExecuteCommand}\n\n',
                        type: TerminalTextType.inactive,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
                if (selectedLocale == null)
                  const Wrap(
                    spacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _LanguageButton(locale: Locale('es'), label: 'ES'),
                      _LanguageButton(locale: Locale('en'), label: 'EN'),
                      _LanguageButton(locale: Locale('it'), label: 'IT'),
                      _LanguageButton(locale: Locale('pt'), label: 'PT'),
                    ],
                  ),
                const SizedBox(height: 20),
                if (selectedLocale != null) ...[
                  SpartanPulsingText(
                    text: t.tapAnywhereInitialize,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(136, 57, 138, 231),
                      fontSize: 18,
                      height: 1.6,
                      fontFamily: 'Courier',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageButton extends ConsumerWidget {
  final Locale locale;
  final String label;

  const _LanguageButton({
    required this.locale,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(localeProvider) == locale;

    return OutlinedButton(
      onPressed: () => ref.read(localeProvider.notifier).state = locale,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: selected ? Colors.greenAccent : Colors.white54),
        backgroundColor:
            selected ? Colors.green.withOpacity(0.2) : Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.greenAccent : Colors.white70,
          fontFamily: 'Courier',
        ),
      ),
    );
  }
}
