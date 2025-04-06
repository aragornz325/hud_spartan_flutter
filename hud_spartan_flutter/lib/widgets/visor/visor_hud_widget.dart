import 'dart:ui';
import 'package:flutter/material.dart';

class VisorHudOverlay extends StatefulWidget {

  const VisorHudOverlay({required this.baseColor, super.key});
  final Color baseColor;

  @override
  State<VisorHudOverlay> createState() => _VisorHudOverlayState();
}

class _VisorHudOverlayState extends State<VisorHudOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scannerPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _scannerPosition = Tween<double>(begin: -0.2, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayColor = widget.baseColor.withAlpha((0.15 * 255).round());

    return Stack(
      children: [
        // Fondo degradado basado en el color dominante
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                overlayColor.withAlpha((0.4 * 255).round()),
                Colors.black.withAlpha((0.9 * 255).round()),
              ],
            ),
          ),
        ),

        // Líneas decorativas HUD
        Positioned.fill(
          child: CustomPaint(
            painter:
                HudGraphicsPainter(color: widget.baseColor.withAlpha(0x4D)),
          ),
        ),

        // Filtro de blur sutil
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: Container(color: Colors.transparent),
        ),

        // Línea escáner animada
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Align(
              alignment: Alignment(0, _scannerPosition.value * 2 - 1),
              child: Container(
                height: 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      widget.baseColor.withAlpha((0.3 * 255).round()),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class HudGraphicsPainter extends CustomPainter {
  HudGraphicsPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const spacing = 20;
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
