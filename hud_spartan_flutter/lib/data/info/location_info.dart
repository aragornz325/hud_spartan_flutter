

import 'package:hud_spartan_flutter/models/loadout_extra_info_item.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

const List<LoadoutExtraInfoItem> loadLocationInfo = [
  LoadoutExtraInfoItem(
    label: 'Location:',
    labelType: TerminalTextType.info,
    description: 'Parana, Argentina',
    descriptionType: TerminalTextType.neutro,
  ),
  LoadoutExtraInfoItem(
    label: 'Additional Info:',
    labelType: TerminalTextType.info,
    description: 'Hailing from Hasenkamp, a small town with a big heart, rooted in culture and resilience',
    descriptionType: TerminalTextType.neutro,
  ),
  
];
  