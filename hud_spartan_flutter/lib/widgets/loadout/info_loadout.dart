import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hud_spartan_flutter/data/info/data_info.dart';
import 'package:hud_spartan_flutter/data/info/ia_info.dart';
import 'package:hud_spartan_flutter/data/info/location_info.dart';
import 'package:hud_spartan_flutter/data/info/status_info.dart';
import 'package:hud_spartan_flutter/data/info/tech_info.dart';
import 'package:hud_spartan_flutter/models/loadout_extra_info_item.dart';
import 'package:hud_spartan_flutter/models/loadout_info_item.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

class DataInfoLoadout extends StatefulWidget {
  final VoidCallback? onUpdate;
  final String command;

  const DataInfoLoadout({this.onUpdate, super.key, required this.command});

  @override
  State<DataInfoLoadout> createState() => _DataInfoLoadoutState();
}

class LoadoutResult {
  final List<LoadoutInfoItem> infoItems;
  final List<LoadoutExtraInfoItem> extraInfoItems;

  const LoadoutResult({
    this.infoItems = const [],
    this.extraInfoItems = const [],
  });
}

class _DataInfoLoadoutState extends State<DataInfoLoadout> {
  final List<Widget> _lines = [];
  final List<Widget> _linesExtraInfo = [];

  @override
  void initState() {
    super.initState();

    final modifier = _extractModifier(widget.command);
    final result = _getLoadoutForModifier(modifier);

    _startSequence(result);
  }

  String? _extractModifier(String cmd) {
    final parts = cmd.trim().split(' ');
    if (parts.length > 1) {
      return parts.sublist(1).join(' ');
    }
    return null;
  }

  LoadoutResult _getLoadoutForModifier(String? modifier) {
    switch (modifier) {
      case '--status':
        return LoadoutResult(extraInfoItems: loadStatusInfo);
      case '--tech':
        return LoadoutResult(extraInfoItems: loadTechnologyInfo);
      case '--location':
        return LoadoutResult(extraInfoItems: loadLocationInfo);
      case '--ia':
        return LoadoutResult(extraInfoItems: loadIAInfo);
      case '--origin':
        return LoadoutResult(extraInfoItems: [
          LoadoutExtraInfoItem(
            label: 'Location: ',
            labelType: TerminalTextType.info,
            description: 'Parana, Argentina',
            descriptionType: TerminalTextType.defaultType,
          ),
          LoadoutExtraInfoItem(
            label: 'Additional Info: ',
            labelType: TerminalTextType.info,
            description:
                'Hailing from Hasenkamp, a small town with a big heart, rooted in culture and resilience.',
            descriptionType: TerminalTextType.defaultType,
          ),
        ]);
      default:
        return LoadoutResult(infoItems: loadInfo);
    }
  }

  Future<void> _appendExtraInfoLine(LoadoutExtraInfoItem line) async {
    setState(() {
      _linesExtraInfo.add(Row(
        children: [
          TerminalText(
            text: line.label,
            type: line.labelType,
          ),
          TerminalText(
            text: line.description,
            type: line.descriptionType,
          ),
        ],
      ));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onUpdate?.call();
    });
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

  Future<void> _startSequence(LoadoutResult result) async {
    for (final info in result.infoItems) {
      await _appendLine(info.data, info.type);
      await Future.delayed(const Duration(milliseconds: 200));
    }

    for (final extra in result.extraInfoItems) {
      await _appendExtraInfoLine(extra);
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._lines,
        ..._linesExtraInfo,
      ],
    );
  }
}
