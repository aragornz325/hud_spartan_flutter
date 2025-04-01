import 'package:hud_spartan_flutter/models/loadout_item.dart';
import 'package:hud_spartan_flutter/widgets/text/terminal_text.dart';

const oniPhrases = [
  "[REDACTED]",
  "ACCESS OVERRIDE PROTOCOL INITIATED",
  "BLACKBOX STREAM DECRYPTED",
  "SUBJECT: ███████",
  ">>> ONI SIGINT TRACE LOG >>>",
  "[CLASSIFIED TRANSMISSION DETECTED]",
  "PROJECT: INIT.BACKEND.DART",
  "AI CONTAINMENT FAILSAFE",
];

const List<LoadoutItem> oniDataLoadout = [
  LoadoutItem(
    label: 'The Civilian',
    tech: '',
    description:
        '''Spartan-117 — but in civilian terms, I'm a full-stack developer and backend specialist, currently working to expand the use of Dart and Serverpod across real-world systems.''',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'Father and Husband',
    tech: '',
    description:
        '''I’m also a husband to the most wonderful woman on Earth, and a father to two amazing sons who give my life purpose beyond code.''',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'The Survivor',
    tech: '',
    description:
        '''I'm a Christian, shaped by faith and tested by adversity. My path has not been easy—diagnosed with a chronic, incurable condition that carries social stigma, I lost both my parents early, and I’ve faced age discrimination in tech across Latin America. 
        Still, like any Spartan, when my shields are down and the world hits hard, I pause… let my systems recharge… and I keep moving forward.
        I love fishing and playing guitar. My favorite book is *The Lord of the Rings*. I’m drawn to the philosophy of Taoism and often find strength in its stillness.''',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'the Dreamer',
    tech: '',
    description: '''My ambitions stretch beyond code.",
    "I want my sons to walk a world where choosing your path isn't a privilege, but a given — where passion can feed a family.",
    "I long for a world where those at the bottom aren’t crushed by the weight above them, but lifted by justice and opportunity.",
    "I imagine a day when the silent majority no longer bows to the corrupt few — when voices rise, and false crowns fall.",
    "I envision an Africa no longer spoken for, but speaking loud — sovereign, proud, and unbroken.",
    "I believe in building systems that don't just work, but work *for* people — tools that protect freedom instead of threatening it.",
    "Among these many visions, one takes shape in my hands: a decentralized eCommerce platform, where value moves freely, wallet to wallet, with no masters and no middlemen.''',
    type: TerminalTextType.neutro,
  ),
  LoadoutItem(
    label: 'The Warrior',
    tech: '',
    description:
        '''I’m not just a developer. I’m a survivor, a dreamer, and a warrior — forged by fire, guided by hope, and committed to building technology that liberates.''',
    type: TerminalTextType.neutro,
  ),
];
