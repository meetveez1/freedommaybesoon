import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/app_enums.dart';
import '../../theme/app_gradients.dart';

class AppShellBackground extends StatelessWidget {
  const AppShellBackground({
    super.key,
    required this.variant,
    required this.interfaceMode,
    required this.animationsEnabled,
    required this.child,
  });

  final ThemeVariant variant;
  final InterfaceMode interfaceMode;
  final bool animationsEnabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(gradient: AppGradients.build(variant)),
          child: const SizedBox.expand(),
        ),
        if (interfaceMode == InterfaceMode.animated && animationsEnabled)
          const Positioned.fill(child: _FloatingSquares()),
        child,
      ],
    );
  }
}

class _FloatingSquares extends StatefulWidget {
  const _FloatingSquares();

  @override
  State<_FloatingSquares> createState() => _FloatingSquaresState();
}

class _FloatingSquaresState extends State<_FloatingSquares>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _SquaresPainter(_controller.value),
        );
      },
    );
  }
}

class _SquaresPainter extends CustomPainter {
  _SquaresPainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.08);
    for (var i = 0; i < 14; i++) {
      final shift = sin((t + i) * pi) * 20;
      final left = (size.width / 14) * i + shift;
      final top = (size.height / 12) * ((i * 3) % 10) + shift;
      final s = 40.0 + (i % 4) * 18.0;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, s, s),
        const Radius.circular(10),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SquaresPainter oldDelegate) => oldDelegate.t != t;
}
