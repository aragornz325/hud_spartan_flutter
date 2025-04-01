import 'package:flutter/material.dart';
import 'package:hud_spartan_flutter/data/commands/commands_data.dart';
import 'package:hud_spartan_flutter/data/oni/oni_data.dart';
import 'package:hud_spartan_flutter/data/tactics/tactics_data.dart';
import 'package:hud_spartan_flutter/data/weapons/weapons_data.dart';
import 'package:hud_spartan_flutter/theme/spartan_theme.dart';
import 'package:hud_spartan_flutter/widgets/loadout/data_loadout.dart';
import 'package:hud_spartan_flutter/widgets/loadout/data_oni_loadout%20.dart';
import 'package:hud_spartan_flutter/widgets/loadout/info_loadout.dart';
import 'package:hud_spartan_flutter/widgets/loadout/mission_loadout.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

class HudScreen extends StatelessWidget {
  const HudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'SPARTAN-HUD INTERFACE ONLINE',
                style: TextStyle(
                  color: SpartanColors.defaultText,
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: _CommandTerminal(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommandTerminal extends StatefulWidget {
  const _CommandTerminal();

  @override
  State<_CommandTerminal> createState() => _CommandTerminalState();
}

class _CommandTerminalState extends State<_CommandTerminal> {
  final ScrollController _scrollController = ScrollController();
  final List<Widget> _outputWidgets = [];
  final TextEditingController _controller = TextEditingController();
  bool _hasExecutedFirstCommand = false;

  @override
  void initState() {
    super.initState();
    _outputWidgets.add(
      const TerminalText(
        text: "type 'help' to view available commands",
        type: TerminalTextType.neutro,
      ),
    );
  }

  void _handleCommand(String command) async {
    if (!_hasExecutedFirstCommand) {
      setState(() {
        _outputWidgets.clear();
        _hasExecutedFirstCommand = true;
      });
    }

    setState(() {
      _outputWidgets.add(
        TerminalText(
          text: '> $command',
          type: TerminalTextType.defaultType,
        ),
      );
      _controller.clear();
    });

    await for (final widget
        in parseCommand(command, onUpdate: _scrollToBottom)) {
      if (widget is _ClearTerminal) {
        setState(() {
          _outputWidgets.clear();
        });
        return;
      }

      setState(() {
        _outputWidgets.add(widget);
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _outputWidgets.length,
            itemBuilder: (context, index) {
              return _outputWidgets[index];
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'λ //>',
              style: TextStyle(
                color: SpartanColors.defaultText,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: _handleCommand,
                style: const TextStyle(
                  color: SpartanColors.neutro,
                  fontFamily: 'Courier',
                ),
                decoration: const InputDecoration(
                  hintText: 'Type command...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                cursorColor: SpartanColors.neutro,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ClearTerminal extends StatelessWidget {
  const _ClearTerminal();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

Stream<Widget> parseCommand(String command, {VoidCallback? onUpdate}) async* {
  switch (command.trim().toLowerCase()) {
    // commandos publicos
    case 'weapons':
      yield DataLoadout(
        accessMessage: '> [ACCESSING SPARTAN-RMQ-117 COMBAT INTERFACE...]',
        loadingMessage: '> [LOADING WEAPONS LOADOUT...]\n',
        completionMessage: '\n> [LOADOUT COMPLETE.]',
        items: weaponsLoadout,
        onUpdate: onUpdate,
      );
    case 'missions':
      yield MissionLoadoutSimple(
        onUpdate: onUpdate,
      );
    case 'clear':
      yield const _ClearTerminal();
      break;
    case 'tactics':
      yield DataLoadout(
        accessMessage: '> [ACCESSING SPARTAN-RMQ-117 COMBAT INTERFACE...]',
        loadingMessage: '> [LOADING TACTICAL LOADOUT...]\n',
        completionMessage: '\n> [LOADOUT COMPLETE.]',
        items: tacticsLoadout,
        onUpdate: onUpdate,
      );

      break;
    case final cmd when cmd.startsWith('info'):
      yield DataInfoLoadout(
        command: cmd,
        onUpdate: onUpdate,
      );
      break;
    case 'help':
      yield DataLoadout(
        accessMessage: '> [ACCESSING AVAILABLE COMMANDS...]',
        delayAccessMessage: Duration(milliseconds: 200),
        loadingMessage: '> [COMMANDS FOUND]\n',
        delayLoadingMessage: Duration(milliseconds: 200),
        completionMessage: '\n> [ONI COMMANDS NOT SHOWN]',
        items: availableCommandsLoadout,
        onUpdate: onUpdate,
      );
      break;

    // ONI commands
    case 'whoami':
      yield const DataOniLoadout(
        completionMessage: '> [TRANSMISSION CLOSED...]',
        items: oniDataLoadout,
      );
      break;

    default:
      yield TerminalText(
        text: "Command '$command' not recognized.",
        type: TerminalTextType.error,
      );
      break;
  }
}
