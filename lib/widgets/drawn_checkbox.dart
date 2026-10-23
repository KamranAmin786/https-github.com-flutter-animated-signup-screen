import 'package:flutter/material.dart';

/// A checkbox whose tick is drawn like a pen stroke.
class DrawnCheckbox extends StatelessWidget {
  const DrawnCheckbox({super.key, required this.value, required this.onTap});

  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6C4CF1);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value ? purple : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: value ? purple : const Color(0xFFC9C4D9),
            width: 2,
          ),
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: value ? 1 : 0),
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          builder: (context, progress, _) =>
              CustomPaint(painter: _TickPainter(progress)),
        ),
      ),
    );
  }
}

class _TickPainter extends CustomPainter {
  _TickPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final tick = Path()
      ..moveTo(size.width * 0.22, size.height * 0.52)
      ..lineTo(size.width * 0.42, size.height * 0.72)
      ..lineTo(size.width * 0.78, size.height * 0.3);

    // Keep only the first part of the path, so the tick draws itself.
    final metric = tick.computeMetrics().first;
    final partial = metric.extractPath(0, metric.length * progress);

    canvas.drawPath(
      partial,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_TickPainter old) => old.progress != progress;
}
