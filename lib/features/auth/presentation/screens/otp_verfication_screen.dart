import 'dart:async';
import 'dart:developer';

import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/features/auth/controller/auth_controller.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import 'create_account_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool resendOtp = false;
  late Timer countTimer;
  bool isSubmitButtonActive = false;
  ValueNotifier<int> resendOtpIn = ValueNotifier(90);

  late AuthController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(AuthController());
    startTimer();
    super.initState();
  }

  void startTimer() {
    countTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (--resendOtpIn.value == 0) {
        setState(() {
          resendOtp = true;
          resendOtpIn.value = 45;
          timer.cancel();
          countTimer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countTimer.cancel();
    // pinController.dispose();
    super.dispose();
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    log("message");
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: appColors.primaryBlueColor,
                                    size: 30,
                                  )),
                              Column(
                                children: [
                                  Text(
                                    'OTP Verification',
                                    textAlign: TextAlign.center,
                                    style: appTextStyles.p308002E2E,
                                  ),
                                  Text(
                                    'Please enter OTP sent to your email',
                                    textAlign: TextAlign.center,
                                    style: appTextStyles.p16400AEB0C3,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              )
                            ],
                          ),
                          13.h.verticalSpace,
                          const AppAppBarShadowWidget(),
                          20.h.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                // ========
                                70.h.verticalSpace,
                                Pinput(
                                  controller: controller.otpController,
                                  length: 4,
                                  focusedPinTheme: PinTheme(
                                    width: 64.w,
                                    height: 64.h,
                                    textStyle: appTextStyles.p164001EBlue,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: appColors.primaryBlueColor),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                  defaultPinTheme: PinTheme(
                                    width: 64.w,
                                    height: 64.h,
                                    textStyle: appTextStyles.p16400ADB, // cFDFDFD
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: appColors.cADB0C3),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                  onCompleted: (value) {
                                    setState(() {
                                      isSubmitButtonActive = true;
                                    });
                                  },
                                ),
                                20.h.verticalSpace,
                                resendOtp
                                    ? InkWell(
                                        onTap: () {
                                          if (isSubmitButtonActive) {}
                                          setState(() {
                                            resendOtp = false;
                                            isSubmitButtonActive = false;
                                            controller.otpController.clear();
                                            startTimer();
                                            controller.forgotPassword();
                                          });
                                        },
                                        child: Text(
                                          "Resend OTP",
                                          style: appTextStyles.p16400AEB0C3
                                              .copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      appColors.primaryBlueColor),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Resend OTP in ",
                                            style: appTextStyles.p16400AEB0C3,
                                          ),
                                          ValueListenableBuilder(
                                            valueListenable: resendOtpIn,
                                            builder: (context, value, child) =>
                                                Text(
                                              '${value}s',
                                              style: appTextStyles.p164001EBlue,
                                            ),
                                          )
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AppBlueButton(
                          title: "Submit",
                          isInactive: !isSubmitButtonActive,
                          onTap: () async {
                            if (controller.otpController.text.isEmpty) {
                              myAlertDialog(context: context,message: 'Enter Four Digit Otp');
                              // Get.snackbar('OTP', 'Enter four digit otp');
                            } else {
                              if (await controller.verifyOTP()) {
                                Get.offAndToNamed(
                                    appRouteNames.newPasswordScreen);
                              } else {
                                myAlertDialog(context: context,message: 'Invalid Otp');
                                // Get.snackbar('Otp', 'Invalid Otp ');
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
           ),
    ));
  }
}
