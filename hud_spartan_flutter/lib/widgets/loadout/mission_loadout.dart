import 'package:flutter/material.dart';
import 'package:hud/data/missions/missions_data.dart';
import 'package:hud/widgets/text/terminal_text.dart';



class MissionLoadoutSimple extends StatefulWidget {
   final VoidCallback? onUpdate;
  const MissionLoadoutSimple({super.key, this.onUpdate});

  @override
  State<MissionLoadoutSimple> createState() => _MissionLoadoutSimpleState();
}

class _MissionLoadoutSimpleState extends State<MissionLoadoutSimple> {
  final ScrollController _scrollController = ScrollController();
  final List<Widget> _lines = [];
  bool _waitingForTap = false;
  int _missionIndex = 0;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await _addLine(
        '[ACCESSING OPERATIONAL HISTORY...]', TerminalTextType.warning);
    await Future.delayed(const Duration(milliseconds: 600));
    for (final mission in missionLog) {
      await _addLine('>>> Decrypting...', TerminalTextType.decrypt);
      await Future.delayed(const Duration(milliseconds: 900));
      await _addLine(
          '→ [${mission.organization}] ${mission.title} | ${mission.period}',
          TerminalTextType.defaultType);
      for (final detail in mission.details) {
        await _addLine(detail, _detectStatusType(detail));
        await Future.delayed(const Duration(milliseconds: 150));
      }
      await _addLine(
        '[MISSION LOG ENTRY ${_missionIndex.toString().padLeft(3, '0')}]',
        TerminalTextType.neutro,
      );
      _missionIndex++;

      await _waitForTap();
    }
    await _addLine('>>> No more missions in log.', TerminalTextType.warning);
  }

  Future<void> _addLine(String text, TerminalTextType type) async {
    setState(() {
      _lines.add(TerminalText(text: text, type: type));
    });

    widget.onUpdate?.call();
    
    // Esperar a que el nuevo frame se construya
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _waitForTap() async {
    setState(() => _waitingForTap = true);
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      return _waitingForTap;
    });
  }

  void _onTap() {
    if (_waitingForTap) {
      setState(() {
        _waitingForTap = false;
        _lines.add(const TerminalText(
          text: '→ Tap received. Proceeding...',
          type: TerminalTextType.neutro,
        ));
      });
    }
  }

  TerminalTextType _detectStatusType(String text) {
    if (text.toLowerCase().contains('status: active')) {
      return TerminalTextType.success;
    }
    if (text.toLowerCase().contains('status: terminated')) {
      return TerminalTextType.error;
    }
    return TerminalTextType.defaultType;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.opaque,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._lines,
            if (_waitingForTap)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: TerminalText(
                  text: 'Tap to continue...',
                  type: TerminalTextType.neutro,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
