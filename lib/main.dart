import 'dart:developer';
import 'dart:io';
import 'package:equicare/common/functions/app_functions_for_subscriptions.dart';
import 'package:equicare/firebase_options.dart';
import 'package:equicare/repo/app_preferences.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:upgrader/upgrader.dart';
import 'my_app_provider.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  runApp(MyAppProvider());
  await _configureSdk();
}

Future<void> _configureSdk() async {
  if (Platform.isAndroid) {
    revenueCatConfigurationConstant = PurchasesConfiguration(
      revenueCatConstants.androidRevenueApiKey,
    );
  } else if (Platform.isIOS) {
    revenueCatConfigurationConstant =
        PurchasesConfiguration(revenueCatConstants.appleRevenueApiKey);
  }
  if (revenueCatConfigurationConstant != null) {
    await Purchases.configure(revenueCatConfigurationConstant!);
  }
}
