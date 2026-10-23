import 'dart:math';

import 'package:flutter/material.dart';

/// Fires a burst of confetti when [ConfettiState.burst] is called.
class Confetti extends StatefulWidget {
  const Confetti({super.key});

  @override
  State<Confetti> createState() => ConfettiState();
}

class ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2500),
  );
  final _pieces = <_Piece>[];

  void burst() {
    final random = Random(7);
    const colors = [
      Color(0xFFFF4FA3),
      Color(0xFF6C4CF1),
      Color(0xFF3FA9FF),
      Color(0xFFF5A524),
      Color(0xFF22C55E),
    ];
    _pieces
      ..clear()
      ..addAll(
        List.generate(140, (_) {
          final angle = -pi / 2 + (random.nextDouble() - 0.5) * pi * 0.9;
          final speed = 650 + random.nextDouble() * 650;
          return _Piece(
            velocity: Offset(cos(angle), sin(angle)) * speed,
            color: colors[random.nextInt(colors.length)],
            spin: (random.nextDouble() - 0.5) * 12,
            size: 8 + random.nextDouble() * 8,
          );
        }),
      );
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          size: Size.infinite,
          painter: _ConfettiPainter(_pieces, _controller.value),
        ),
      ),
    );
  }
}

class _Piece {
  _Piece({
    required this.velocity,
    required this.color,
    required this.spin,
    required this.size,
  });

  final Offset velocity;
  final Color color;
  final double spin;
  final double size;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.pieces, this.t);

  final List<_Piece> pieces;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    if (t == 0 || t == 1) return;
    final seconds = t * 2.5;
    const gravity = 900.0;
    final origin = Offset(size.width / 2, size.height * 0.55);
    final paint = Paint();

    for (final p in pieces) {
      // Simple physics: start fast, then gravity pulls every piece down.
      final position =
          origin +
          p.velocity * seconds +
          Offset(0, 0.5 * gravity * seconds * seconds);
      paint.color = p.color.withValues(alpha: 1 - t);
      canvas.save();
      canvas.translate(position.dx, position.dy);
      canvas.rotate(p.spin * seconds);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.6,
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => true;
}
