// ignore_for_file: prefer_const_constructors

import 'package:equicare/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:equicare/features/home/presentation/screens/home_screen.dart';
import 'package:equicare/features/my_calendar/presentation/screens/my_calendar_screen.dart';
import 'package:equicare/features/my_stable/presentation/screens/my_stable_screen.dart';
import 'package:equicare/features/profile/presentation/screens/profile_screen.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentIdx = 0;
  var allScreens = [
    HomeScreen(),
    MyStableScreen(),
    MyCalendarScreen(),
    ContactsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(0.06),
                offset: Offset(0, -4),
                spreadRadius: 0,
                blurRadius: 18,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // =======================================
                InkWell(
                  onTap: () {
                    setState(() {
                      currentIdx = 0;
                    });
                  },
                  child: Column(
                    children: [
                      // homeIconSvg
                      SvgPicture.asset(
                        appIcons.homeIconSvg,
                        color: currentIdx == 0
                            ? appColors.c1E4475
                            : appColors.cCBCDD7,
                      ),
                      5.h.verticalSpace,
                      Text(
                        "Home",
                        style: currentIdx == 0
                            ? appTextStyles.p12500313131
                            : appTextStyles.p12500AEB0C3,
                      ),
                    ],
                  ),
                ),

                // =======================================
                InkWell(
                  onTap: () {
                    setState(() {
                      currentIdx = 1;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        appIcons.horseIconSvg,
                        color: currentIdx == 1
                            ? appColors.c1E4475
                            : appColors.cCBCDD7,
                      ),
                      5.h.verticalSpace,
                      Text(
                        "My Stable",
                        style: currentIdx == 1
                            ? appTextStyles.p12500313131
                            : appTextStyles.p12500AEB0C3,
                      ),
                    ],
                  ),
                ),

                // =======================================
                InkWell(
                  onTap: () {
                    setState(() {
                      currentIdx = 2;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        appIcons.calendarIconSvg,
                        color: currentIdx == 2
                            ? appColors.c1E4475
                            : appColors.cCBCDD7,
                      ),
                      5.h.verticalSpace,
                      Text(
                        "Calendar",
                        style: currentIdx == 2
                            ? appTextStyles.p12500313131
                            : appTextStyles.p12500AEB0C3,
                      ),
                    ],
                  ),
                ),

                // =======================================
                InkWell(
                  onTap: () {
                    setState(() {
                      currentIdx = 3;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        appIcons.contactsIconSvg,
                        color: currentIdx == 3
                            ? appColors.c1E4475
                            : appColors.cCBCDD7,
                      ),
                      5.h.verticalSpace,
                      Text(
                        "Contacts",
                        style: currentIdx == 3
                            ? appTextStyles.p12500313131
                            : appTextStyles.p12500AEB0C3,
                      ),
                    ],
                  ),
                ),

                // =======================================
                InkWell(
                  onTap: () {
                    setState(() {
                      currentIdx = 4;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 30,
                        color: currentIdx == 4
                            ? appColors.c1E4475
                            : appColors.cCBCDD7,
                      ),
                      Text(
                        "Profile",
                        style: currentIdx == 4
                            ? appTextStyles.p12500313131
                            : appTextStyles.p12500AEB0C3,
                      ),
                    ],
                  ),
                ),

                // =======================================
              ],
            ),
          ],
        ),
      ),
      body: allScreens[currentIdx],
    );
  }
}
