import 'package:flutter/material.dart';
import '../../theme/spartan_theme.dart';

enum TerminalTextType {
  defaultType,
  success,
  warning,
  error,
  neutro,
  decrypt,
  oni,
  inactive,
  info
}

class TerminalText extends StatelessWidget {
  const TerminalText({
    required this.text,
    super.key,
    this.type = TerminalTextType.defaultType,
  });
  final String text;
  final TerminalTextType type;

  static TextStyle getStyle(TerminalTextType type) {
    switch (type) {
      case TerminalTextType.decrypt:
        return const TextStyle(
          color: SpartanColors.decrypt,
          fontFamily: 'JetBrainsMono',
          fontWeight: FontWeight.bold,
        );
      case TerminalTextType.info:
        return const TextStyle(
          color: SpartanColors.info,
          fontFamily: 'JetBrainsMono',
        );
      case TerminalTextType.success:
        return const TextStyle(
          color: SpartanColors.success,
          fontFamily: 'JetBrainsMono',
        );
      case TerminalTextType.warning:
        return const TextStyle(
          color: SpartanColors.warning,
          fontFamily: 'JetBrainsMono',
        );
      case TerminalTextType.error:
        return const TextStyle(
          color: SpartanColors.error,
          fontFamily: 'JetBrainsMono',
        );
      case TerminalTextType.inactive:
        return const TextStyle(
          color: SpartanColors.inactive,
          fontFamily: 'JetBrainsMono',
          letterSpacing: 1.2,
        );
      case TerminalTextType.oni:
        return const TextStyle(
          color: Color(0xFF8A2BE2),
          fontFamily: 'JetBrainsMono',
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
                color: Colors.deepPurpleAccent,
                blurRadius: 4,
                offset: Offset(0, 0)),
          ],
        );
      case TerminalTextType.neutro:
        return const TextStyle(
          color: SpartanColors.neutro,
          fontFamily: 'JetBrainsMono',
        );
      case TerminalTextType.defaultType:
        return const TextStyle(
          color: SpartanColors.defaultText,
          fontFamily: 'JetBrainsMono',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getStyle(type),
    );
  }
}
