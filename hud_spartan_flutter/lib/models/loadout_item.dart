import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

class LoadoutItem {
  final String label;
  final String tech;
  final String description;
  final TerminalTextType? type;

  const LoadoutItem({
    required this.label,
    required this.tech,
    required this.description,
    this.type,
  });
}