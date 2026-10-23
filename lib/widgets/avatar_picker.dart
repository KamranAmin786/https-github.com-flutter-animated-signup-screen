import 'package:flutter/material.dart';

/// A row of avatars. The picked one grows and gets a glowing ring.
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final int selected;
  final ValueChanged<int> onSelect;

  static const _icons = [
    Icons.face,
    Icons.pets,
    Icons.rocket_launch,
    Icons.music_note,
  ];
  static const _colors = [
    Color(0xFFFF4FA3),
    Color(0xFFF5A524),
    Color(0xFF6C4CF1),
    Color(0xFF3FA9FF),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < _icons.length; i++)
          GestureDetector(
            onTap: () => onSelect(i),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              scale: i == selected ? 1.15 : 0.9,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: i == selected ? _colors[i] : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: [
                    if (i == selected)
                      BoxShadow(
                        color: _colors[i].withValues(alpha: 0.45),
                        blurRadius: 14,
                      ),
                  ],
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: i == selected ? 1 : 0.55,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: _colors[i],
                    child: Icon(_icons[i], color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
