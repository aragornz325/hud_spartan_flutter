import 'package:hud_spartan_flutter/models/loadout_info_item.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

const List<LoadoutInfoItem> loadInfo = [
  LoadoutInfoItem(
    data: 'System Name: Spartan-rmq-117 Terminal Interface',
    type: TerminalTextType.warning,
  ),
  LoadoutInfoItem(
    data: 'Real Identity: Rodrigo Martín Quintero',
    type: TerminalTextType.neutro,
  ),
  LoadoutInfoItem(
    data:
        'Technology Stack: Next.js, React, TailwindCSS, TypeScript, Serverpod, PostgreSQL',
    type: TerminalTextType.neutro,
  ),
  LoadoutInfoItem(
    data: 'Technology Current: Flutter, Dart, Riverpod, GetX, Dio, Hive',
    type: TerminalTextType.success,
  ),
  LoadoutInfoItem(
    data:
        'AI Integration: Fully designed and developed with assistance from advanced AI systems',
    type: TerminalTextType.neutro,
  ),
  LoadoutInfoItem(
    data:
        'Design Philosophy: Inspired by Spartan tactical systems and Halo universe aesthetics.',
    type: TerminalTextType.neutro,
  ),
  LoadoutInfoItem(
    data:
        'Core Purpose: Showcase of skills, values, and technological mastery.',
    type: TerminalTextType.neutro,
  ),
  LoadoutInfoItem(
    data: 'Location: Parana, Argentina',
    type: TerminalTextType.warning,
  ),
  LoadoutInfoItem(
    data:
        'Mission: Empower the web through backend innovation, decentralization, and purposeful design',
    type: TerminalTextType.warning,
  ),
  LoadoutInfoItem(
    data:
        'Tip: Use info --origin, info --status, etc. to access specific modules.',
    type: TerminalTextType.inactive,
  ),
];
