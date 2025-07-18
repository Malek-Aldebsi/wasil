class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email must not be empty';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password must not be empty';
    if (value.length < 6) return 'Password too short (min 6 chars)';
    return null;
  }
}
