/// The three rules a good password has to pass.
class PasswordRules {
  const PasswordRules(this.password);

  final String password;

  bool get longEnough => password.length >= 8;
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get hasUpper => password.contains(RegExp(r'[A-Z]'));

  int get passed => [longEnough, hasNumber, hasUpper].where((ok) => ok).length;
}
