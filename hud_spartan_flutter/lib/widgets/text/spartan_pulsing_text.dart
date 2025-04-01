import 'package:flutter/material.dart';

class SpartanPulsingText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final double minScale;
  final double maxScale;
  final TextAlign? textAlign;

  const SpartanPulsingText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(
      milliseconds: 1300,
    ),
    this.minScale = 1.0,
    this.maxScale = 1.05,
    this.textAlign,
  });

  @override
  State<SpartanPulsingText> createState() => _SpartanPulsingTextState();
}

class _SpartanPulsingTextState extends State<SpartanPulsingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(
        reverse: true,
      );

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Text(
        widget.text,
        style: widget.style,
        textAlign: widget.textAlign,
      ),
    );
  }
}
