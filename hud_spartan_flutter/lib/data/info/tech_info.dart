import 'package:hud_spartan_flutter/models/loadout_extra_info_item.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

const List<LoadoutExtraInfoItem> loadTechnologyInfo = [
  LoadoutExtraInfoItem(
    label: 'frontend:',
    labelType: TerminalTextType.info,
    description:
        'Flutter Framework & Dart Language - Cross-Platform Development',
    descriptionType: TerminalTextType.neutro,
  ),
  LoadoutExtraInfoItem(
    label: 'backend:',
    labelType: TerminalTextType.info,
    description: 'Serverpod - Dart Backend Framework',
    descriptionType: TerminalTextType.neutro,
  ),
  LoadoutExtraInfoItem(
    label: 'database:',
    labelType: TerminalTextType.info,
    description: 'PostgreSQL - Relational Database Management System',
    descriptionType: TerminalTextType.neutro,
  ),
  LoadoutExtraInfoItem(
    label: 'cloud:',
    labelType: TerminalTextType.info,
    description:
        'Vercel && Railway - Cloud Platform for Hosting and Deployment ',
    descriptionType: TerminalTextType.neutro,
  ),
];
