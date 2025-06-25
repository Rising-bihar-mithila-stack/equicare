import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/controller/auth_controller.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../common/validator/validator.dart';
import 'create_account_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Forgot Password?',
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
                      20.h.verticalSpace,
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextField(
                                  hintText: "Enter Email",
                                  textEditingController:
                                      controller.forgotEmailController,
                                  title: "Email"),
                              15.h.verticalSpace,
                              Text(
                                "Please provide your email to reset your password",
                                style: appTextStyles.p164008183,
                              ),
                              Spacer(),
                              AppBlueButton(
                                title: "Submit",
                                onTap: () async {
                                  if (controller
                                      .forgotEmailController.text.isEmpty) {
                                    myAlertDialog(context: context,message: 'Please Enter Your Email');
                                    // Get.snackbar(
                                    //     'Email', 'please enter your email');
                                  } else if (validateEmail(
                                      controller.forgotEmailController.text)) {
                                    if (await controller.forgotPassword()) {
                                      Get.offAndToNamed(
                                          appRouteNames.otpVerificationScreen);
                                    } else {
                                      myAlertDialog(context: context,message: 'There Is No Account Registered With Us With Requested Email Address.');
            
                                      // Get.snackbar('Alert',
                                      //     'There is no account registered with us with requested email address.');
                                    }
                                  } else {
                                    myAlertDialog(context: context,message: 'Enter Valid Email');
            
                                    // Get.snackbar('Email', 'Enter valid email');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      20.h.verticalSpace,
                    ],
                  ),
                ),
              ),
          ),
    ));
  }
}
