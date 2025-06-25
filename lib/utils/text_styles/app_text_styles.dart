import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static final AppTextStyles _singleton = AppTextStyles._internal();

  factory AppTextStyles() {
    return _singleton;
  }

  AppTextStyles._internal();

  TextStyle p26900 = TextStyle(
      fontFamily: "Pangram", fontWeight: FontWeight.w900, fontSize: 26.spMin);

  TextStyle p16500 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
  );
  TextStyle p26500313131 = TextStyle(
    fontSize: 26.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c313131,
  );
  TextStyle p26700 = TextStyle(
    fontSize: 26.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w700,
  );
  TextStyle p125008183 = TextStyle(
    fontSize: 12.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c818393,
  );
  TextStyle p12500313131 = TextStyle(
    fontSize: 12.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c313131,
  );
  TextStyle p12500AEB0C3 = TextStyle(
    fontSize: 12.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.cAEB0C3,
  );
  TextStyle p308002E2E = TextStyle(
    fontSize: 30.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w800,
    color: appColors.c2E2E2E,
  );
  TextStyle p30800white = TextStyle(
    fontSize: 30.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w800,
    color: appColors.white,
  );
  TextStyle p16400ADB = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.cADB0C3,
  );
  TextStyle p16400313131 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c313131,
  );
  TextStyle p164008183 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c818393,
  );
  TextStyle p18500313131 = TextStyle(
    fontSize: 18.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c313131,
  );
  TextStyle p185001E44Blue = TextStyle(
    fontSize: 18.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c1E4475,
  );
  TextStyle p14400313131 = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c313131,
  );
  TextStyle p144008082 = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c808292,
  );
  TextStyle p144001E44Blue = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c1E4475,
  );
  TextStyle p144008183 = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c818393,
  );
  TextStyle p14500White = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.white,
  );
  TextStyle p14500818393 = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c818393,
  );
  TextStyle p14500AEB0C3 = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.cAEB0C3,
  );
  TextStyle p145001EBlue = TextStyle(
    fontSize: 14.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c1E4475,
  );
  TextStyle p165001E4475 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c1E4475,
  );
  TextStyle p16500818393 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c818393,
  );
  TextStyle p16500313131 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c313131,
  );
  TextStyle p16500White = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  TextStyle p165003DABGreen = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w500,
    color: appColors.c3DAB48,
  );
  TextStyle p16400AEB0C3 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c313131,
  );
  TextStyle p164001EBlue = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.c1E4475,
  );
  TextStyle p16400DDD9 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: appColors.cDDD9EA,
  );
  TextStyle p16400White = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  TextStyle p167003131 = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w700,
    color: appColors.c313131,
  );
  TextStyle p167001EBlue = TextStyle(
    fontSize: 16.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w700,
    color: appColors.c1E4475,
  );
  TextStyle p207001EBlue = TextStyle(
    fontSize: 20.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w700,
    color: appColors.c1E4475,
  );
  TextStyle p24700313131 = TextStyle(
    fontSize: 24.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w700,
    color: appColors.c313131,
  );

  TextStyle p26700313131 = TextStyle(
    fontSize: 26.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w700,
    color: appColors.c313131,
  );
  TextStyle p287003131 = TextStyle(
    fontSize: 28.spMin,
    fontFamily: 'Pangram',
    fontWeight: FontWeight.w700,
    color: appColors.c313131,
  );

//
}
