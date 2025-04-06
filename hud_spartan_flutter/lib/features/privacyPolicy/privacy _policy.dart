import 'package:flutter/material.dart';
import 'package:hud/l10n/l10n.dart';
import 'package:hud/theme/spartan_theme.dart';
import 'package:hud/widgets/text/terminal_text.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpartanColors.background,
      appBar: AppBar(
        title: Text(context.l10n.privacyPolicy),
        centerTitle: true,
        backgroundColor: SpartanColors.defaultText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TerminalText(
                text: context.l10n.privacyPolicy,
                type: TerminalTextType.error,
              ),
              const SizedBox(height: 16),
              TerminalText(
                text: context.l10n.notGetAnyInfo,
                type: TerminalTextType.neutro,
              ),
              const SizedBox(height: 16),
              TerminalText(
                text: '📷 ${context.l10n.cameraPermission}',
                type: TerminalTextType.neutro,
              ),
              TerminalText(
                text: context.l10n.cameraPermissionDescription,
                type: TerminalTextType.neutro,
              ),
              const SizedBox(height: 16),
              TerminalText(
                text: '🔒 ${context.l10n.userPrivacy}',
                type: TerminalTextType.neutro,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    _buildPrivacyLine(
                      context.l10n.noPersonalInformationCollected,
                    ),
                    _buildPrivacyLine(
                      context.l10n.noDataStoredServers,
                    ),
                    _buildPrivacyLine(
                      context.l10n.noDataSharedThirdParties,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              TerminalText(text: context.l10n.appRunsCompletelyLocally),
              const SizedBox(height: 16),
              TerminalText(
                text: context.l10n.contact,
                type: TerminalTextType.neutro,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: context.l10n.contactDescription,
                        ),
                        const TextSpan(
                          text: '  rodrigo.m.quintero@gmail.com',
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPrivacyLine(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        ' > ',
        style: TextStyle(
          color: SpartanColors.defaultText,
          fontFamily: 'Courier',
        ),
      ),
      Expanded(
        child: TerminalText(
          text: text,
          type: TerminalTextType.warning,
        ),
      ),
    ],
  );
}
