import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _singleton = AppColors._internal();

  factory AppColors() {
    return _singleton;
  }

  AppColors._internal();

  Color white = Colors.white;
  Color black = Colors.black;
  Color cFDFDFD = const Color(0xFFFDFDFD);
  Color c2E2E2E = const Color(0xFF2E2E2E);
  Color cADB0C3 = const Color(0xFFADB0C3);
  Color c313131 = const Color(0xFF313131);
  Color cAEB0C3 = const Color(0xFFAEB0C3);
  Color cDFDFDF = const Color(0xFFDFDFDF); // #
  Color c1E4475 = const Color(0xFF1E4475);
  Color primaryBlueColor = const Color(0xFF1E4475);
  Color c808292 = const Color(0xFF808292);
  Color c818393 = const Color(0xFF818393);
  Color cF2F2F2 = const Color(0xFFF2F2F2);
  Color cCBCDD7 = const Color(0xFFCBCDD7);
  Color cDDD9EA = const Color(0xFFDDD9EA);
  Color cEAEAEA = const Color(0xFFEAEAEA);
  Color cE5E7F4 = const Color(0xFFE5E7F4);
  Color cF6F6F6 = const Color(0xFFF6F6F6);
  Color cE9EBF8 = const Color(0xFFE9EBF8);
  Color cFFF4F3 = const Color(0xFFFFF4F3);
  Color cEA4335 = const Color(0xFFEA4335);
  Color cFBEAE9 = const Color(0xFFFBEAE9);
  Color c3DAB48 = const Color(0xFF3DAB48);
  Color cE6E6E6 = const Color(0xFFE6E6E6);
  Color cEAEBF1 = const Color(0xFFEAEBF1);
  Color cF0F2F2 = const Color(0xFFF0F2F2);
}
