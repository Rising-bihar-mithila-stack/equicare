import 'dart:developer';

import 'package:equicare/common/functions/app_functions_for_subscriptions.dart';
import 'package:equicare/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:equicare/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:upgrader/upgrader.dart';

import 'bottom_navigation_bar.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/subscription/presentation/subscription_screen.dart';
import 'repo/app_preferences.dart';
import 'utils/constants/app_constants.dart';
import 'utils/locale/app_localization_delegate.dart';
import 'utils/locale/locale_constant.dart';
import 'utils/routes/app_route_pages.dart';

class MyAppProvider extends StatefulWidget {
  const MyAppProvider({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppProviderState>();
    state?.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppProviderState();
}

class _MyAppProviderState extends State<MyAppProvider> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeftWithFade,
      popGesture: Get.isPopGestureEnable,
      opaqueRoute: Get.isOpaqueRouteDefault,
      getPages: routesPages,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
              alwaysUse24HourFormat: false),
          child: child ?? const Text("N/A"),
        );
      },
      title: 'TeleMechanic',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      theme: ThemeData(
          scaffoldBackgroundColor: appColors.cF6F6F6,
          // scaffoldBackgroundColor: appColors.cFDFDFD,
          appBarTheme: AppBarTheme(
            backgroundColor: appColors.cFDFDFD,
          )),
      home: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => UpgradeAlert(
            barrierDismissible: false,
            showLater: false,
            showIgnore: false,
            upgrader: Upgrader(),
            child: StartNavigation()),
      ),
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

/// =================================================
class StartNavigation extends StatefulWidget {
  const StartNavigation({super.key});

  @override
  State<StartNavigation> createState() => _StartNavigationState();
}

class _StartNavigationState extends State<StartNavigation> {
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() async {
    // await AppPreferences().deleteToken();
    String? token = await AppPreferences().getToken();
    //  await AppFunctionForSubscriptions().grantOrRevokeFullAccess(isGrant: false);
    isUserSubUserConstant = await AppPreferences().getIsSubUser();
    // if (token != null)

    {
      var userProfile = await AppFunctionForSubscriptions().getUserProfile();
      if (userProfile != null) {
        revenueCatConfigurationConstant?.appUserID = userProfile.id.toString();
      }
      Purchases.addCustomerInfoUpdateListener(
        (customerInfo) {
          log("customerInfo ---> $customerInfo");
          isUserHaveActiveSubscriptionConstant =
              customerInfo.activeSubscriptions.isNotEmpty;
          log("isUserHaveActiveSubscriptionConstant ---> $isUserHaveActiveSubscriptionConstant");
          if (userProfile?.hasFullAccess == true) {
            isUserHaveActiveSubscriptionConstant = userProfile?.hasFullAccess;
          }
          if ((isUserHaveActiveSubscriptionConstant == true ||
                  isUserSubUserConstant == true) &&
              token != null) {
            Get.offAllNamed(appRouteNames.bottomNavigationBarScreen);
          } else if (token != null &&
              isUserHaveActiveSubscriptionConstant != true) {
            // Get.offAllNamed(appRouteNames.subscriptionScreen);
            isUserHaveActiveSubscriptionConstant =true;
            Get.offAllNamed(appRouteNames.bottomNavigationBarScreen);
          }

          log(" configurationnnn --->${isUserHaveActiveSubscriptionConstant} ${isUserSubUserConstant}");
        },
      );
      log("userProfileee ---> ${userProfile?.toJson()}");
    }

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    // return OnboardingScreen();
    return LoginScreen();
    // return BottomNavigationBarScreen();
    // return SubscriptionScreen();
    // return LoginScreen();
  }
}
