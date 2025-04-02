import 'package:flutter/widgets.dart';
import 'package:hud/l10n/l10n.dart';

extension L10nX on BuildContext {
  AppLocalizations get t => AppLocalizations.of(this)!;
}
