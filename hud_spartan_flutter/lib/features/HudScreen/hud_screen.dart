import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hud/theme/spartan_theme.dart';
import 'package:hud/widgets/hud_terminal/command_parser.dart';
import 'package:hud/widgets/text/terminal_text.dart';
import 'package:hud/widgets/visor/visor_hud_widget.dart';
import 'package:palette_generator/palette_generator.dart';

final interactiveModeProvider = StateProvider<bool>((ref) => false);

class HudScreen extends ConsumerStatefulWidget {
  const HudScreen({super.key});

  @override
  ConsumerState<HudScreen> createState() => _HudScreenState();
}

class _HudScreenState extends ConsumerState<HudScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Widget> _outputWidgets = [];
  final TextEditingController _controller = TextEditingController();
  bool _hasExecutedFirstCommand = false;
  Color _dynamicBackground = Colors.black;
  Timer? _colorUpdateTimer;
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _outputWidgets.add(
      const TerminalText(
        text: "type 'help' to view available commands",
        type: TerminalTextType.neutro,
      ),
    );
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.low);
    await _cameraController!.initialize();

    // Capturamos color cada 3 segundos
    _colorUpdateTimer = Timer.periodic(Duration(seconds: 3), (_) {
      _updateBackgroundColor();
    });
  }

  Future<void> _updateBackgroundColor() async {
    if (!_cameraController!.value.isInitialized) return;

    try {
      final file = await _cameraController!.takePicture();
      final palette = await PaletteGenerator.fromImageProvider(
        FileImage(File(file.path)),
      );

      setState(() {
        _dynamicBackground = palette.dominantColor?.color ?? Colors.black;
      });
    } catch (_) {
      // Si falla, ignoramos para mantener HUD activo
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _colorUpdateTimer?.cancel();
    super.dispose();
  }

  Future<void> _handleCommand(String command) async {
    final isInteractive = ref.read(interactiveModeProvider);
    if (isInteractive) return;

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
        ),
      );
      _controller.clear();
    });

    await for (final widget in parseCommand(
      command,
      context,
      onUpdate: _scrollToBottom,
    )) {
      if (widget is ClearTerminal) {
        setState(_outputWidgets.clear);
        return;
      }

      if (widget is StatefulWidget || widget is StatelessWidget) {
        if (widget.runtimeType.toString().contains('HailingSignal')) {
          ref.read(interactiveModeProvider.notifier).state = true;
        }
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
    final isInteractive = ref.watch(interactiveModeProvider);

    return Scaffold(
      backgroundColor: _dynamicBackground, // 💡 cambio aquí
      body: SafeArea(
        child: Stack(
          children: [
            if (_cameraController != null &&
                _cameraController!.value.isInitialized)
              Positioned.fill(
                child: CameraPreview(_cameraController!),
              ),

            // Efecto de opacidad y blur sobre la cámara
            Positioned.fill(
              child: Container(
                child: VisorHudOverlay(baseColor: _dynamicBackground),
              ),
            ),

            // Terminal Spartan encima
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SPARTAN-HUD INTERFACE ONLINE',
                      style: TextStyle(color: SpartanColors.defaultText),
                    ),
                    const SizedBox(height: 12),
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
                    if (!isInteractive)
                      Row(
                        children: [
                          const Text(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
