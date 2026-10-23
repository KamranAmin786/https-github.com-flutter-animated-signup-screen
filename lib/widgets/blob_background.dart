import 'dart:math';

import 'package:flutter/material.dart';

/// A purple gradient with two soft glowing blobs that slowly float around.
class BlobBackground extends StatefulWidget {
  const BlobBackground({super.key, required this.child});

  final Widget child;

  @override
  State<BlobBackground> createState() => _BlobBackgroundState();
}

class _BlobBackgroundState extends State<BlobBackground>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 8),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _blob(Color color, double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B1035), Color(0xFF3A1D7A)],
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) {
          final a = _controller.value * 2 * pi;
          return Stack(
            children: [
              Positioned(
                top: -60 + sin(a) * 40,
                left: -80 + cos(a) * 30,
                child: _blob(const Color(0xFFFF4FA3), 320),
              ),
              Positioned(
                bottom: -80 + cos(a) * 40,
                right: -90 + sin(a) * 30,
                child: _blob(const Color(0xFF3FA9FF), 360),
              ),
              child!,
            ],
          );
        },
      ),
    );
  }
}
