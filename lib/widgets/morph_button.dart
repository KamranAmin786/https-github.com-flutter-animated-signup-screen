import 'package:flutter/material.dart';

enum ButtonState { idle, loading, success }

/// A button that shrinks into a spinner, then turns into a green check.
class MorphButton extends StatelessWidget {
  const MorphButton({
    super.key,
    required this.label,
    required this.state,
    required this.onTap,
  });

  final String label;
  final ButtonState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final idle = state == ButtonState.idle;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      width: idle ? 300 : 56,
      height: 56,
      decoration: BoxDecoration(
        color: state == ButtonState.success
            ? const Color(0xFF22C55E)
            : const Color(0xFF6C4CF1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: idle ? onTap : null,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: switch (state) {
                ButtonState.idle => Text(
                  label,
                  key: const ValueKey('idle'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ButtonState.loading => const SizedBox(
                  key: ValueKey('loading'),
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
                ButtonState.success => const Icon(
                  Icons.check,
                  key: ValueKey('success'),
                  color: Colors.white,
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
