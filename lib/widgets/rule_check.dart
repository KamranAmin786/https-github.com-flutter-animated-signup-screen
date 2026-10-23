import 'package:flutter/material.dart';

/// One password rule. The circle fills and a check pops in when it passes.
class RuleCheck extends StatelessWidget {
  const RuleCheck({super.key, required this.text, required this.ok});

  final String text;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF22C55E);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ok ? green : Colors.transparent,
              border: Border.all(
                color: ok ? green : const Color(0xFFC9C4D9),
                width: 2,
              ),
            ),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
              scale: ok ? 1 : 0,
              child: const Icon(Icons.check, size: 13, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: ok ? const Color(0xFF1B1035) : const Color(0xFF9A94AD),
              fontWeight: ok ? FontWeight.w600 : FontWeight.w400,
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
