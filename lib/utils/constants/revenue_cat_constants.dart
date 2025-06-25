class RevenueCatConstants {
  static final RevenueCatConstants _singleton = RevenueCatConstants._internal();

  factory RevenueCatConstants() {
    return _singleton;
  }

  RevenueCatConstants._internal();

  String appleRevenueApiKey = "appl_JquojauKuNxzxldCWSkNTWUUgPK";
  String androidRevenueApiKey = "goog_aJGjxxpHmJSoPGAjwXQWwHrgzwp";

  String appUserID = '';
  bool entitlementIsActive = false;
}
