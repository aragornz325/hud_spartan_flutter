

import 'package:hud/models/loadout_extra_info_item.dart';
import 'package:hud/widgets/text/terminal_text.dart';

const List<LoadoutExtraInfoItem> loadStatusInfo = [
  LoadoutExtraInfoItem(
    label: 'System Name:',
    labelType: TerminalTextType.info,
    description: 'Spartan-rmq-117 Terminal Interface',
    descriptionType: TerminalTextType.neutro,
  ),
  LoadoutExtraInfoItem(
    label: 'Mode:',
    labelType: TerminalTextType.info,
    description: 'Active, ready to deploy new features and updates.',
    descriptionType: TerminalTextType.neutro,
  ),
  LoadoutExtraInfoItem(
    label: 'Status:',
    labelType: TerminalTextType.info,
    description: 'All systems operational.',
    descriptionType: TerminalTextType.success,
  ),
  LoadoutExtraInfoItem(
    label: 'Last Update:',
    labelType: TerminalTextType.info,
    description: 'October 2023',
    descriptionType: TerminalTextType.warning,
  ),
  LoadoutExtraInfoItem(
    label: 'Version:',
    labelType: TerminalTextType.info,
    description: '1.0.0',
    descriptionType: TerminalTextType.neutro,
  ),
];
  