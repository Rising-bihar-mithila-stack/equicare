import 'package:dio/dio.dart';
import 'package:equicare/repo/network_client.dart';
import 'package:equicare/utils/assets/icons/app_icons.dart';
import 'package:equicare/utils/routes/app_route_names.dart';
import 'package:purchases_flutter/models/purchases_configuration.dart';

import '../assets/images/app_images.dart';
import '../colors/app_colors.dart';
import '../text_styles/app_text_styles.dart';
import 'revenue_cat_constants.dart';

String? authToken;
Dio appDio = Dio();

AppIcons appIcons = AppIcons();
AppTextStyles appTextStyles = AppTextStyles();
AppColors appColors = AppColors();
AppImages appImages = AppImages();
AppRouteNames appRouteNames = AppRouteNames();
NetworkClient appNetworkClient = NetworkClient();
String? invitationIdConstant;

// revenue cat
RevenueCatConstants revenueCatConstants = RevenueCatConstants();
PurchasesConfiguration? revenueCatConfigurationConstant;
bool? isUserHaveActiveSubscriptionConstant;
bool ? isUserSubUserConstant;
