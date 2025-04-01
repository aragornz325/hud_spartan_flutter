import 'package:hud_spartan_flutter/models/loadout_item.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

const List<LoadoutItem> availableCommandsLoadout = [
  LoadoutItem(
    label: 'clear',
    tech: '',
    description: 'clear the console',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'help',
    tech: '',
    description: 'view available commands',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'tactics',
    tech: '',
    description: 'Engage soft-skill tactical protocols',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'weapons',
    tech: '',
    description: 'Display Spartan-rmq-117’s current loadout and capabilities',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'mission',
    tech: '',
    description: 'Display all mission logs. Modifiers: [--download]',
    type: TerminalTextType.neutro,
  ),
];
