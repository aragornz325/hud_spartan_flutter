import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hud_spartan_flutter/data/bootsScreen/boot_screen.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> {
  int _currentLine = 0;

  @override
  void initState() {
    super.initState();
    _runBootSequence();
  }

  void _runBootSequence() async {
    for (var i = 0; i < bootLines.length; i++) {
      await Future.delayed(
        const Duration(
          milliseconds: 800,
        ),
      );
      setState(() {
        _currentLine = i + 1;
      });
    }

    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    if (mounted) {
      context.go(
        '/hud',
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_currentLine, (
              index,
            ) {
              return TerminalText(
                text: bootLines[index]['text'],
                type: bootLines[index]['type'],
              );
            }),
          ),
        ),
      ),
    );
  }
}
