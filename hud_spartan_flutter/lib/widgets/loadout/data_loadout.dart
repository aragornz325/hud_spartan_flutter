import 'package:flutter/material.dart';
import 'package:hud/models/loadout_item.dart';
import '../text/terminal_text.dart';

class DataLoadout extends StatefulWidget {
  final VoidCallback? onUpdate;
  final String accessMessage;
  final String loadingMessage;
  final String completionMessage;
  final List<LoadoutItem> items;
  final Duration delay;
  final Duration delayAccessMessage;
  final Duration delayLoadingMessage;

  const DataLoadout({
    this.onUpdate,
    this.delayAccessMessage = const Duration(
      milliseconds: 600,
    ),
    this.delayLoadingMessage = const Duration(
      milliseconds: 600,
    ),
    super.key,
    required this.accessMessage,
    required this.loadingMessage,
    required this.completionMessage,
    required this.items,
    this.delay = const Duration(milliseconds: 200),
  });

  @override
  State<DataLoadout> createState() => _DataLoadoutState();
}

class _DataLoadoutState extends State<DataLoadout> {
  final List<Widget> _lines = [];

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  Future<void> _appendLine(
    String text,
    TerminalTextType type,
  ) async {
    setState(() {
      _lines.add(
        TerminalText(
          text: text,
          type: type,
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onUpdate?.call();
    });
  }

  Future<void> _startSequence() async {
    await _appendLine(widget.accessMessage, TerminalTextType.warning);
    await Future.delayed(widget.delayAccessMessage);

    await _appendLine(widget.loadingMessage, TerminalTextType.warning);
    await Future.delayed(widget.delayLoadingMessage);

    for (final item in widget.items) {
      final line = '→ [${item.label}] ${item.tech} – ${item.description}';
      await _appendLine(
        line,
        item.type ?? TerminalTextType.defaultType,
      );
      await Future.delayed(
        widget.delay,
      );
    }

    await Future.delayed(
      const Duration(
        milliseconds: 400,
      ),
    );
    await _appendLine(
      widget.completionMessage,
      TerminalTextType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _lines,
      ),
    );
  }
}
