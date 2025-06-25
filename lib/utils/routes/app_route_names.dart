class AppRouteNames {
  static final AppRouteNames _singleton = AppRouteNames._internal();

  factory AppRouteNames() {
    return _singleton;
  }

  AppRouteNames._internal();

  String loginScreen = "/LoginScreen";
  String signUpScreen = "/SignUpScreen";
  String forgetPasswordScreen = "/ForgetPasswordScreen";
  String otpVerificationScreen = "/OtpVerificationScreen";
  // String changePasswordScreen = "/ChangePasswordScreen";
  String createAccountScreen = "/CreateAccountScreen";
  String subscriptionScreen = "/SubscriptionScreen";
  String bottomNavigationBarScreen = "/BottomNavigationBarScreen";
  String eventDetailsScreen = "/EventDetailsScreen";
  String searchEventDetailsScreen = "/SearchEventDetailsScreen";
  String addHorseScreen = "/AddHorseScreen";
  String specificHorseDetailsScreen = "/SpecificHorseDetailsScreen";
  String editHorseScreen = "/EditHorseScreen";
  String addEventScreen = "/AddEventScreen";
  String editEventScreen = "/EditEventScreen";
  String completedEventsScreen = "/CompletedEventsScreen";
  String profileEditScreen = "/ProfileEditScreen";
  String addAndEditContactScreen = "/AddAndEditContactScreen";
  String specificContactDetailScreen = "/SpecificContactDetailScreen";
  String settingScreen = "/SettingScreen";
  String pushNotificationScreen = "/PushNotificationScreen";
  String changeEmailScreen = "/ChangeEmailScreen";
  String changePasswordFromSettingScreen = "/ChangePasswordFromSettingScreen";
  String newPasswordScreen = "/NewPasswordScreen";
  String associatedUsersScreen = "/AssociatedUsersScreen";
  String inviteUserScreen = "/InviteUserScreen";
  String connectionsScreen = "/ConnectionsScreen";
  String invitesSentScreen = "/InvitesSentScreen";
  String searchEventScreen = "/SearchEventScreen";
  String onboardingScreen = "/OnboardingScreen";
}
