import 'package:flutter/material.dart';
import 'package:hud/l10n/l10n.dart';
import 'package:hud/widgets/text/terminal_text.dart';

List<Map<String, dynamic>> getBootLines(BuildContext context) {
  final t = context.l10n;

  final List<Map<String, dynamic>> bootLines = [
    {
      'text': '> ${t.initializingNeuralLink}',
      'type': TerminalTextType.defaultType,
    },
    {
      'text': '> ${t.synchronizingArmorInterface}',
      'type': TerminalTextType.warning,
    },
    {
      'text': '> ${t.connectingToONICore}',
      'type': TerminalTextType.success,
    },
    {
      'text': '> ${t.loadingSpartanTacticalOverlay}',
      'type': TerminalTextType.defaultType
    },
    {
      'text': '> ${t.errorHUDIntegrityCompromised}',
      'type': TerminalTextType.error,
    },
    {
      'text': '> ${t.systemReadyWelcome}',
      'type': TerminalTextType.success,
    },
  ];

  return bootLines;
}
