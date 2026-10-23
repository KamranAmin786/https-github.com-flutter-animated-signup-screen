import 'package:flutter/material.dart';

import '../widgets/animated_field.dart';
import '../widgets/avatar_picker.dart';
import '../widgets/blob_background.dart';
import '../widgets/confetti.dart';
import '../widgets/drawn_checkbox.dart';
import '../widgets/fade_slide.dart';
import '../widgets/morph_button.dart';
import '../widgets/password_rules.dart';
import '../widgets/rule_check.dart';
import '../widgets/strength_meter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late final _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..forward();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confettiKey = GlobalKey<ConfettiState>();
  var _avatar = 0;
  var _hidden = true;
  var _agreed = false;
  var _state = ButtonState.idle;

  @override
  void initState() {
    super.initState();
    // Rebuild on every key press so the meter and rules follow along.
    _password.addListener(() => setState(() {}));
    _email.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _intro.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _email.text.contains('@') &&
      PasswordRules(_password.text).passed == 3 &&
      _agreed;

  Future<void> _signUp() async {
    setState(() => _state = ButtonState.loading);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => _state = ButtonState.success);
    _confettiKey.currentState?.burst();
  }

  @override
  Widget build(BuildContext context) {
    final done = _state == ButtonState.success;
    return Scaffold(
      body: BlobBackground(
        child: Stack(
          children: [
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      ScaleTransition(
                        scale: CurvedAnimation(
                          parent: _intro,
                          curve: const Interval(
                            0,
                            0.5,
                            curve: Curves.elasticOut,
                          ),
                        ),
                        child: const _Logo(),
                      ),
                      const SizedBox(height: 16),
                      FadeSlide(
                        controller: _intro,
                        start: 0.1,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            done ? 'Welcome aboard!' : 'Create account',
                            key: ValueKey(done),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      FadeSlide(
                        controller: _intro,
                        start: 0.15,
                        child: const Text(
                          'It takes less than a minute',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeSlide(
                        controller: _intro,
                        start: 0.25,
                        child: _card(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(child: Confetti(key: _confettiKey)),
          ],
        ),
      ),
    );
  }

  Widget _card() {
    final rules = PasswordRules(_password.text);
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlide(
            controller: _intro,
            start: 0.3,
            child: AvatarPicker(
              selected: _avatar,
              onSelect: (i) => setState(() => _avatar = i),
            ),
          ),
          const SizedBox(height: 18),
          FadeSlide(
            controller: _intro,
            start: 0.38,
            child: AnimatedField(
              label: 'Email',
              icon: Icons.mail_outline,
              controller: _email,
            ),
          ),
          const SizedBox(height: 12),
          FadeSlide(
            controller: _intro,
            start: 0.46,
            child: AnimatedField(
              label: 'Password',
              icon: Icons.lock_outline,
              controller: _password,
              obscure: _hidden,
              suffix: IconButton(
                onPressed: () => setState(() => _hidden = !_hidden),
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) =>
                      RotationTransition(turns: animation, child: child),
                  child: Icon(
                    _hidden ? Icons.visibility_off : Icons.visibility,
                    key: ValueKey(_hidden),
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            child: _password.text.isEmpty
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Column(
                      children: [
                        StrengthMeter(score: rules.passed),
                        const SizedBox(height: 8),
                        RuleCheck(text: '8+ characters', ok: rules.longEnough),
                        RuleCheck(text: 'One number', ok: rules.hasNumber),
                        RuleCheck(
                          text: 'One uppercase letter',
                          ok: rules.hasUpper,
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 14),
          FadeSlide(
            controller: _intro,
            start: 0.54,
            child: Row(
              children: [
                DrawnCheckbox(
                  value: _agreed,
                  onTap: () => setState(() => _agreed = !_agreed),
                ),
                const SizedBox(width: 10),
                const Text(
                  'I agree to the Terms',
                  style: TextStyle(fontSize: 14, color: Color(0xFF1B1035)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FadeSlide(
            controller: _intro,
            start: 0.6,
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _canSubmit || _state != ButtonState.idle ? 1 : 0.4,
                child: IgnorePointer(
                  ignoring: !_canSubmit,
                  child: MorphButton(
                    label: 'Create account',
                    state: _state,
                    onTap: _signUp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFFFF4FA3), Color(0xFF6C4CF1)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4FA3).withValues(alpha: 0.5),
            blurRadius: 30,
          ),
        ],
      ),
      child: const Icon(Icons.person_add_alt_1, color: Colors.white, size: 36),
    );
  }
}
