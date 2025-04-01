import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hud_spartan_flutter/widgets/text/spartan_pulsing_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.go('/boot'),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Thank you for visiting my site.\n\n'
                  "You're about to enter a fully interactive portfolio,\n"
                  'designed to emulate a Spartan HUD from the Halo universe.\n\n'
                  'Engage, explore, and execute commands as if you were inside ONI Command.\n\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                    height: 1.6,
                    fontFamily: 'Courier',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                  ),
                  child: const SpartanPulsingText(
                    text: 'Tap anywhere to initialize immediately...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(
                        136,
                        57,
                        138,
                        231,
                      ),
                      fontSize: 18,
                      height: 1.6,
                      fontFamily: 'Courier',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Awaiting user input...',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
