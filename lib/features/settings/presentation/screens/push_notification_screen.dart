import 'package:equicare/repo/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  bool switchButton = false;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        switchButton = await AppPreferences().getIsNotification() ?? false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back, color: appColors.c1E4475),
                ),
                Text(
                  'Push Notifications',
                  textAlign: TextAlign.center,
                  style: appTextStyles.p308002E2E,
                ),
                SizedBox(width: 32.w),
              ],
            ),
            4.verticalSpace,
            AppAppBarShadowWidget(),
            15.verticalSpace,
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 7,
                      child: Text(
                        'I want to receive push notifications for the activities.',
                        style: appTextStyles.p164008183,
                      )),
                  Flexible(
                    flex: 2,
                    child: Switch(
                      value: switchButton,
                      onChanged: (value) {
                        switchButton = !switchButton;

                        setState(() {});
                        AppPreferences().setIsNotification(switchButton);
                      },
                      activeColor: appColors.c1E4475,
                      activeTrackColor: appColors.c818393.withOpacity(0.15),
                      inactiveThumbColor: appColors.cAEB0C3,
                      inactiveTrackColor: appColors.c818393.withOpacity(0.15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
