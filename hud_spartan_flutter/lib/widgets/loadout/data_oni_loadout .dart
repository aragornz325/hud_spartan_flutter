import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hud/models/loadout_item.dart';
import 'package:hud/widgets/text/glich_text.dart';

import '../text/terminal_text.dart';

class DataOniLoadout extends StatefulWidget {
  final VoidCallback? onUpdate;
  final String completionMessage;
  final List<LoadoutItem> items;
  final Duration delay;

  const DataOniLoadout({
    this.onUpdate,
    super.key,
    required this.completionMessage,
    required this.items,
    this.delay = const Duration(milliseconds: 200),
  });

  @override
  State<DataOniLoadout> createState() => _DataOniLoadoutState();
}

class _DataOniLoadoutState extends State<DataOniLoadout> {
  final List<Widget> _lines = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  Future<void> _appendLine(String text, TerminalTextType type,
      {bool glitch = false}) async {
    setState(() {
      if (glitch) {
        _lines.add(GlitchText(text: text));
      } else {
        _lines.add(TerminalText(text: text, type: type));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onUpdate?.call();
    });
  }

  Future<void> _appendTemporaryLine(
      String text, TerminalTextType type, Duration visibleDuration) async {
    final tempKey = UniqueKey();

    setState(() {
      _lines.add(KeyedSubtree(
        key: tempKey,
        child: TerminalText(text: text, type: type),
      ));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onUpdate?.call();
    });

    await Future.delayed(visibleDuration);

    setState(() {
      _lines.removeWhere((widget) => widget.key == tempKey);
    });
  }

  Future<void> _startSequence() async {
    await _appendLine("> ONI directive accepted.", TerminalTextType.oni);
    await Future.delayed(const Duration(milliseconds: 600));

    await _appendLine(
        "> Using front camera for retina scan...", TerminalTextType.oni);
    await Future.delayed(const Duration(milliseconds: 600));

    for (int i = 0; i < 2; i++) {
      await _appendTemporaryLine("> Scanning...", TerminalTextType.oni,
          const Duration(milliseconds: 500));
      await Future.delayed(const Duration(milliseconds: 200));
    }

    await _appendLine(
        "> ONI agent presence confirmed.", TerminalTextType.success);
    await Future.delayed(const Duration(milliseconds: 600));

    await _appendLine("> ONI privileges granted.", TerminalTextType.success);
    await Future.delayed(const Duration(milliseconds: 600));

    await _appendLine(
        "> Decrypting classified information...", TerminalTextType.warning);
    await Future.delayed(const Duration(milliseconds: 1000));

    for (final item in widget.items) {
      final line = '→ [${item.label}] ${item.tech} – ${item.description}';
      await _appendLine(line, TerminalTextType.oni);
      await Future.delayed(widget.delay);
    }

    await Future.delayed(const Duration(milliseconds: 400));
    await _appendLine(widget.completionMessage, TerminalTextType.success);

    await Future.delayed(const Duration(milliseconds: 600));
    await _appendLine("> ONI privileges revoked.", TerminalTextType.neutro);
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(_lines.length),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _lines,
      ),
    );
  }
}
