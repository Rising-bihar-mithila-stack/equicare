String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }

  // A more comprehensive regex for email validation
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (!emailRegex.hasMatch(value)) {
    return 'Invalid email address';
  }
  return null; // Return null if the email is valid
}

bool validateEmail(String email) {
  return email.isNotEmpty && RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(email);
}
