# Animated Sign Up Screen in Flutter (No Packages)

Source code for the YouTube tutorial on the **Orhan Yazdan** channel:
**Animated Sign Up Screen in Flutter (No Packages)**: https://www.youtube.com/@orhanyazdan

![Demo](docs/demo.gif)

## What's inside

Every animation is plain Flutter, with no packages:

- **Avatar picker**: the picked avatar grows with a glowing ring (`AnimatedScale`, `AnimatedContainer`, `AnimatedOpacity`)
- **Password strength meter**: the bar grows and changes color (`AnimatedFractionallySizedBox`, `AnimatedSwitcher`)
- **Rule checks**: each rule ticks itself off with a pop (`AnimatedScale` + `Curves.elasticOut`)
- **Drawn checkbox**: the tick draws itself like a pen (`CustomPainter` + `PathMetric.extractPath`)
- **Morphing button**: the button turns into a spinner, then a green check
- **Confetti**: 140 pieces with simple physics (`CustomPainter`)
- **Staggered entrance**: one `AnimationController` with `Interval`s

## Files

```
lib/
  main.dart
  screens/signup_screen.dart
  widgets/
    avatar_picker.dart     password_rules.dart   strength_meter.dart
    rule_check.dart        drawn_checkbox.dart   confetti.dart
    blob_background.dart   animated_field.dart   fade_slide.dart
    morph_button.dart
```

`blob_background.dart`, `animated_field.dart`, `fade_slide.dart` and `morph_button.dart` come from the Animated Login Screen video.

## Run it

```bash
git clone <this repo>
cd flutter-animated-signup-screen
flutter pub get
flutter run
```

Tested with Flutter 3.47 (Dart 3.9+). Works on Android, iOS and web.

## Credits

Font: [Inter](https://rsms.me/inter/) by Rasmus Andersson (SIL Open Font License 1.1).

If this helped you, subscribe to the channel for more Flutter UI and animation tutorials.
