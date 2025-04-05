import 'package:flutter/material.dart';
import 'package:hud/l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hud/providers/email/email_service_provider.dart';
import 'package:hud/widgets/buttons/halo_button.dart';

enum HailingStep {
  confirm,
  email,
  phone,
  location,
  message,
  review,
  sending,
  done,
}

class HailingSignal extends ConsumerStatefulWidget {
  const HailingSignal({required this.onComplete, super.key});
  final VoidCallback onComplete;

  @override
  ConsumerState<HailingSignal> createState() => _HailingSignalState();
}

class _HailingSignalState extends ConsumerState<HailingSignal> {
  HailingStep step = HailingStep.confirm;
  String email = '';
  String phone = '';
  String location = '';
  String message = '';
  String error = '';
  List<String> log = [];

  bool get isMobile => MediaQuery.of(context).size.width < 600;

  void next(HailingStep nextStep) {
    setState(() {
      step = nextStep;
      error = '';
    });
  }

  Future<void> sendBeacon() async {
    final emailService = ref.read(emailServiceProvider);

    setState(() {
      step = HailingStep.sending;
      log = [
        '> ${context.l10n.transmittingData}',
        '> ${context.l10n.encodingSignal}',
        '> ${context.l10n.openingChannelToSpartan}',
      ];
    });

    try {
      await emailService.sendEmail(
        phone,
        location,
        email: email,
        message: message,
      );

      log
        ..add('> Signal acknowledged')
        ..add('> Spartan inbound...');
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        step = HailingStep.done;
      });
    } catch (e) {
      setState(() {
        error = 'Signal failed: ${e.toString()}';
        step = HailingStep.review;
      });
    }
  }

  bool isEmailValid(String e) => e.contains('@') && e.contains('.');
  bool isPhoneValid(String p) => RegExp(r'^[0-9\+\-\s]{6,}\$').hasMatch(p);

  Widget _buildInput({
    required String label,
    required String value,
    required Function(String) onChanged,
    required VoidCallback onNext,
    bool showError = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontFamily: 'Courier',
            ),
          ),
          TextField(
            key: ValueKey(label),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Courier',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            autofocus: true,
            cursorColor: Colors.greenAccent,
            onChanged: onChanged,
            onSubmitted: (_) => onNext(),
          ),
          if (showError && error.isNotEmpty)
            Text(
              error,
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
        ],
      ),
    );
  }

  Widget _yesNoPrompt(
    String message,
    VoidCallback onYes,
    VoidCallback onNo,
  ) {
    final mobile = MediaQuery.sizeOf(context).width < 600;

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Courier',
            ),
          ),
          const SizedBox(height: 8),
          if (mobile)
            Row(
              children: [
                haloButton('YES', onYes, Colors.green),
                const SizedBox(width: 12),
                haloButton('NO', onNo, Colors.red),
              ],
            )
          else
            TextField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Courier',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Type Y or N',
              ),
              autofocus: true,
              onSubmitted: (value) {
                final lower = value.toLowerCase();
                if (lower == 'y') onYes();
                if (lower == 'n') onNo();
              },
            ),
          if (error.isNotEmpty)
            Text(error, style: const TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case HailingStep.confirm:
        return _yesNoPrompt(
          '${context.l10n.thisWillInitiateHailingSignal}\n\n',
          () => next(HailingStep.email),
          widget.onComplete,
        );
      case HailingStep.email:
        return _buildInput(
          label: '> Enter your serial ID (email):',
          value: email,
          onChanged: (val) => setState(() => email = val),
          onNext: () {
            if (isEmailValid(email)) {
              next(HailingStep.phone);
            } else {
              setState(() => error = 'Invalid email.');
            }
          },
          showError: true,
        );
      case HailingStep.phone:
        return _buildInput(
          label: '> Enter your badge number (phone - optional):',
          value: phone,
          onChanged: (val) => setState(() => phone = val),
          onNext: () {
            if (phone.isEmpty || !isPhoneValid(phone)) {
              next(HailingStep.location);
            } else {
              setState(() => error = 'Invalid phone number.');
            }
          },
          showError: true,
        );
      case HailingStep.location:
        return _buildInput(
          label: '> Indicate your location (optional):',
          value: location,
          onChanged: (val) => setState(() => location = val),
          onNext: () => next(HailingStep.message),
        );
      case HailingStep.message:
        return _buildInput(
          label: '> Message:',
          value: message,
          onChanged: (val) => setState(() => message = val),
          onNext: () {
            if (message.trim().isNotEmpty) {
              next(HailingStep.review);
            } else {
              setState(() => error = 'Message required.');
            }
          },
          showError: true,
        );
      case HailingStep.review:
        return _yesNoPrompt(
          'All fields collected.Transmit the beacon?',
          sendBeacon,
          widget.onComplete,
        );
      case HailingStep.sending:
        return Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: log
                .map((line) => Text(line,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'Courier')))
                .toList(),
          ),
        );
      case HailingStep.done:
        return const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            'Hailing frequency opened.\nAwaiting acknowledgement from Spartan-rmq-117\nFrequency closed...',
            style: TextStyle(color: Colors.white, fontFamily: 'Courier'),
          ),
        );
    }
  }
}
