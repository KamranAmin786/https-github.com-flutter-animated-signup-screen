import 'package:flutter/material.dart';

/// A bar that grows and changes color as the password gets stronger.
class StrengthMeter extends StatelessWidget {
  const StrengthMeter({super.key, required this.score});

  /// How many rules passed, from 0 to 3.
  final int score;

  static const _colors = [
    Color(0xFFE5484D),
    Color(0xFFF5A524),
    Color(0xFF3B82F6),
    Color(0xFF22C55E),
  ];
  static const _labels = ['Too weak', 'Weak', 'Good', 'Strong'];

  @override
  Widget build(BuildContext context) {
    final color = _colors[score];
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFECE9F5),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.centerLeft,
            child: AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              widthFactor: (score + 1) / 4,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 72,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: Text(
              _labels[score],
              key: ValueKey(score),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
