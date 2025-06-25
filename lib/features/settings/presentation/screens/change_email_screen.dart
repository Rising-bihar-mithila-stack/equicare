import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/buttons/app_blue_button.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            18.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: appColors.c1E4475,
                    )),
                Text(
                  'Change Email',
                  textAlign: TextAlign.center,
                  style: appTextStyles.p308002E2E,
                ),
                SizedBox(
                  width: 40,
                )
              ],
            ),
            4.h.verticalSpace,
            const AppAppBarShadowWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  AppTextField(
                      hintText: ' Enter Email',
                      textEditingController: TextEditingController(),
                      title: 'New Email'),
                  5.h.verticalSpace,
                  Text(
                    'Please provide your new email to update your email address for Equicare',
                    style: appTextStyles.p164008183,
                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
          child: AppBlueButton(
            title: 'Change',
            onTap: () {
              Get.toNamed(appRouteNames.otpVerificationScreen);
            },
          ),
        ),
      ],
    ));
  }
}
