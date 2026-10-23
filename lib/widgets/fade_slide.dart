import 'package:flutter/material.dart';

/// Fades and slides a child up, during one slice of a shared controller.
class FadeSlide extends StatelessWidget {
  const FadeSlide({
    super.key,
    required this.controller,
    required this.start,
    required this.child,
  });

  final AnimationController controller;
  final double start;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start, start + 0.4, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(curve),
        child: child,
      ),
    );
  }
}
