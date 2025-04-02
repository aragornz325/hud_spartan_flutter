

import 'package:hud/widgets/text/terminal_text.dart';

class LoadoutExtraInfoItem {
  final String label;
  final TerminalTextType labelType;
  final String description;
  final TerminalTextType descriptionType;

  const LoadoutExtraInfoItem({
    required this.descriptionType,
    required this.labelType,
    required this.label,
    required this.description,
  });
}
