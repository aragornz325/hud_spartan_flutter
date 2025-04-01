import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

final List<Map<String, dynamic>> bootLines = [
    {
      'text': '> Initializing neural link...',
      'type': TerminalTextType.defaultType
    },
    {
      'text': '> Synchronizing armor interface...',
      'type': TerminalTextType.warning
    },
    {'text': '> Connecting to ONI Core...', 'type': TerminalTextType.success},
    {
      'text': '> Loading Spartan Tactical Overlay...',
      'type': TerminalTextType.defaultType
    },
    {
      'text': '> ERROR: HUD integrity compromised.',
      'type': TerminalTextType.error
    },
    {
      'text': '> System ready. Welcome, Spartan-117.',
      'type': TerminalTextType.success
    },
  ];