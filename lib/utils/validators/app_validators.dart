class AppValidators {
  static final AppValidators _singleton = AppValidators._internal();

  factory AppValidators() {
    return _singleton;
  }

  AppValidators._internal();

  bool emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      // return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value ?? "")) {
      return false;
    }
    return true;
  }

  bool validatePhoneNumber(String? val) {
    var value = val?.replaceAll("-", "");
    final RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{8,14}$');
    //   final RegExp regex = RegExp(r'^\d{8,10}$');
    if (value == null || value.isEmpty) {
      return false;
    } else if (!phoneRegex.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
