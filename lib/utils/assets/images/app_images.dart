// ""

class AppImages {
  static final AppImages _singleton = AppImages._internal();

  factory AppImages() {
    return _singleton;
  }

  AppImages._internal();

  String horseImageJpg = "assets/images/horse_image.jpg";
  String splashScreenImageJpg = "assets/images/splash_screen.png";
  String cakeImageSvg = "assets/images/cake_image.svg";
  String profileDefaultImage = "assets/images/profile_default.png";
  String loginAndSignupImagePng = "assets/images/login_and_signup.png";
  String defaultProfileImageBg = "assets/images/default_profile_bg";
  String defaultContactImage = "assets/images/default_contact_img.png";
  String emptyContactPng = "assets/images/empty_contacts.png";
  String onBoarding1 = "assets/images/on_boarding1.png";
  String onBoarding2 = "assets/images/on_boarding2.png";
  String onBoarding3 = "assets/images/on_boarding3.png";
}
