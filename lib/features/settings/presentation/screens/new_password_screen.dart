import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/controller/auth_controller.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../common/shadows/app_appbar_shadow_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  late AuthController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(AuthController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () =>
          // controller.isLoading.value
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: GetBuilder<AuthController>(
                    builder: (controller) => SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: appColors.primaryBlueColor,
                          size: 30,
                        )),
                    Text(
                      'New Password',
                      textAlign: TextAlign.center,
                      style: appTextStyles.p308002E2E,
                    ),
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
                10.h.verticalSpace,
                const AppAppBarShadowWidget(),
                16.h.verticalSpace,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                            hintText: "Enter New Password",
                            textEditingController:
                                controller.newPasswordController,
                            title: "New Password"),
                        AppTextField(
                            hintText: "Re-Type New Password",
                            textEditingController:
                                controller.newConfirmPasswordController,
                            title: "Enter New Password"),
                        const Spacer(),
                        AppBlueButton(
                          title: "Save",
                          onTap: () async {
                            if (controller.newPasswordController.text.isEmpty) {
                              myAlertDialog(
                                  message: 'Enter Your New Password',
                                  context: context);
                              // Get.snackbar('New Password',
                              //     'Enter your New Password');
                            } else if (controller
                                .newConfirmPasswordController.text.isEmpty) {
                              myAlertDialog(
                                  message: 'Enter Re-Type New Password',
                                  context: context);
                              // Get.snackbar('Re-Type New Password',
                              //     'Enter Re-Type New Password');
                            } else if (controller
                                    .newConfirmPasswordController.text ==
                                controller.newPasswordController.text) {
                              if (await controller.changePassword()) {
                                Get.offAllNamed(appRouteNames.loginScreen);
                              } else {
                                myAlertDialog(
                                    message: 'Something Went Wrong',
                                    context: context);
            
                                // Get.snackbar(
                                //     'Alert', 'Something went wrong ');
                              }
                            } else {
                              myAlertDialog(
                                  message: 'Please Check Your Re-Type Password',
                                  context: context);
            
                              // Get.snackbar('Alert',
                              //     'Please check your Re-Type Password');
                            }
                          },
                        ),
                        20.h.verticalSpace,
                      ],
                    ),
                  ),
                )
              ],
            ),
                    ),
                  ),
          ),
    ));
  }
}
