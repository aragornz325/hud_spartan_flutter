import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hud/data/commands/commands_data.dart';
import 'package:hud/data/oni/oni_data.dart';
import 'package:hud/data/tactics/tactics_data.dart';
import 'package:hud/data/weapons/weapons_data.dart';
import 'package:hud/utils/l10n_utils.dart';
import 'package:hud/widgets/hailingSignal/hailing_signal.dart';
import 'package:hud/widgets/loadout/data_loadout.dart';
import 'package:hud/widgets/loadout/data_oni_loadout%20.dart';
import 'package:hud/widgets/loadout/info_loadout.dart';
import 'package:hud/widgets/loadout/mission_loadout.dart';
import 'package:hud/widgets/text/terminal_text.dart';

Stream<Widget> parseCommand(
  String command,
  BuildContext context, {
  VoidCallback? onUpdate,
}) async* {
  switch (command.trim().toLowerCase()) {
    // commandos públicos
    case 'weapons':
      yield DataLoadout(
        accessMessage: '> [${context.t.accessingSpartanCombatInterface}]',
        loadingMessage: '> [${context.t.loadingWeaponsLoadout}]\n',
        completionMessage: '\n> [${context.t.loadoutComplete}]',
        items: weaponsLoadout,
        onUpdate: onUpdate,
      );
    case 'missions':
      yield MissionLoadoutSimple(
        onUpdate: onUpdate,
      );
    case 'clear':
      yield const ClearTerminal();
    case 'tactics':
      yield DataLoadout(
        accessMessage: '> [${context.t.accessingSpartanCombatInterface}]',
        loadingMessage: '> [${context.t.loadingTacticalLoadout}]\n',
        completionMessage: '\n> [${context.t.loadoutComplete}]',
        items: tacticsLoadout,
        onUpdate: onUpdate,
      );
    case 'hail':
      yield HailingSignal(
        onComplete: () {
          context.go('/boot');
        },
      );

    case final cmd when cmd.startsWith('info'):
      yield DataInfoLoadout(
        command: cmd,
        onUpdate: onUpdate,
      );
    case 'help':
      yield DataLoadout(
        accessMessage: '> [${context.t.accessingAvailableCommands}]',
        delayAccessMessage: const Duration(
          milliseconds: 200,
        ),
        loadingMessage: '> [${context.t.commandFound}]\n',
        delayLoadingMessage: const Duration(
          milliseconds: 200,
        ),
        completionMessage: '\n> [${context.t.loadoutComplete}]',
        items: availableCommandsLoadout,
        onUpdate: onUpdate,
      );

    // ONI commands
    case 'whoami':
      yield DataOniLoadout(
        completionMessage: '> [${context.t.transmissionClossed}]',
        items: whoamiDataLoadout,
        onUpdate: onUpdate,
      );

    default:
      yield TerminalText(
        text: "Command '$command' not recognized.",
        type: TerminalTextType.error,
      );
  }
}

class ClearTerminal extends StatelessWidget {
  const ClearTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
