import 'package:flutter/material.dart';

/// A text field that glows when it has focus.
class AnimatedField extends StatefulWidget {
  const AnimatedField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.obscure = false,
    this.suffix,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool obscure;
  final Widget? suffix;

  @override
  State<AnimatedField> createState() => _AnimatedFieldState();
}

class _AnimatedFieldState extends State<AnimatedField> {
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = _focus.hasFocus;
    const purple = Color(0xFF6C4CF1);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: active ? Colors.white : const Color(0xFFF2F0F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active ? purple : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          if (active)
            BoxShadow(color: purple.withValues(alpha: 0.25), blurRadius: 16),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focus,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          labelText: widget.label,
          border: InputBorder.none,
          prefixIcon: Icon(widget.icon, color: active ? purple : Colors.grey),
          suffixIcon: widget.suffix,
        ),
      ),
    );
  }
}
