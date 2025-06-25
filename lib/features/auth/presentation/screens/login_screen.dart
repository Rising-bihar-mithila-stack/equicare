import 'dart:developer';

import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/common/validator/validator.dart';
import 'package:equicare/features/auth/controller/auth_controller.dart';
import 'package:equicare/repo/app_preferences.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:equicare/utils/locale/language_intl.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/buttons/app_blue_button.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthController controller;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  bool isPasswordVisible = true;

  void init() async {
    controller = Get.put(AuthController());
    String? inviteId;
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      log("deepLinkkinitialLink ---> $deepLink");
      inviteId = deepLink.toString().split("=")[1];
      invitationIdConstant = inviteId;
    }
    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        // Set up the `onLink` event listener next as it may be received here
        final Uri deepLink = pendingDynamicLinkData.link;
        // Example of using the dynamic link to push the user to a different screen
        log("deepLinkk onLink  ---> $deepLink");
        inviteId = deepLink.toString().split("=")[1];
        log("deepLinkk onLink  ---> $inviteId");
        invitationIdConstant = inviteId;
        Get.toNamed(appRouteNames.signUpScreen);
      },
    );
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EquiCareHorseContainerWidget(),
                    10.h.verticalSpace,
                    Text(
                      'Login',
                      style: appTextStyles.p308002E2E,
                    ),
                    Text(
                      'Please enter your details to login',
                      style: appTextStyles.p16400ADB,
                    ),
                    AppTextField(
                      hintText: "Enter Email",
                      textEditingController: controller.loginEmailController,
                      keyboardType: TextInputType.emailAddress,
                      title: "Email",
                      validator: (p0) {
                        return emailValidator(p0);
                      },
                    ),
                    AppTextField(
                      hintText: "Enter Password",
                      textEditingController: controller.loginPasswordController,
                      title: "Password",
                      isObsecure: isPasswordVisible,
                      isPasswordField: true,
                      onPasswordFieldClicked: () {
                        setState(
                          () {
                            isPasswordVisible = !isPasswordVisible;
                          },
                        );
                      },
                    ),
                    10.h.verticalSpace,
                    InkWell(
                        onTap: () {
                          controller.clearTextField();
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.toNamed(appRouteNames.forgetPasswordScreen);
                        },
                        child: Text('Forgot Password?',
                            style: appTextStyles.p165001E4475)),
                    18.h.verticalSpace,
                    AppBlueButton(
                      title: Languages.of(context)?.login ?? "Login",
                      onTap: () async {
                        if (controller.loginEmailController.text.isEmpty) {
                          myAlertDialog(
                              message: 'Please Enter Your Email',
                              context: context);
                          // Get.snackbar('Email', 'please enter your email');
                        } else if (controller
                            .loginPasswordController.text.isEmpty) {
                          myAlertDialog(
                              message: 'Please Enter Your Password',
                              context: context);
                          // Get.snackbar(
                          //     'Password', 'Pleas enter your password');
                        } else if (validateEmail(
                            controller.loginEmailController.text)) {
                          try {
                            if (await controller.loginAccount()) {
                              controller.clearTextField();
                              // Get.offAndToNamed(
                              //     appRouteNames.bottomNavigationBarScreen);
                              // log("loninn ---> isUserHaveActiveSubscriptionConstant:$isUserHaveActiveSubscriptionConstant isUserSubUserConstant:$isUserSubUserConstant");
                              if (isUserHaveActiveSubscriptionConstant ==
                                      true ||
                                  isUserSubUserConstant == true) {
                                Get.offAndToNamed(
                                    appRouteNames.bottomNavigationBarScreen);
                              } else {
                                Get.toNamed(appRouteNames.subscriptionScreen);
                              }
                            }
                          } catch (e) {
                            myAlertDialog(message: '$e', context: context);
                          }
                        } else {
                          myAlertDialog(
                              message: 'Enter Valid Email & Password',
                              context: context);
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          20.h.verticalSpace,
                          InkWell(
                            onTap: () {
                              controller.clearTextField();
                              Get.offAndToNamed(appRouteNames.signUpScreen);
                              // Get.offAndToNamed(appRouteNames.addAndEditContactScreen);
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Doesn’t have an account? ',
                                    style: appTextStyles.p16400313131,
                                  ),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: appTextStyles.p165001E4475.copyWith(
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          18.h.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  String myUrl =
                                      'https://www.equicare.com.au/terms-of-use';
                                  if (!await launchUrl(
                                    Uri.parse(myUrl),
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw Exception(
                                        'Could not launch ==>> $myUrl');
                                  }
                                },
                                child: Text(
                                  'Terms & Conditions',
                                  textAlign: TextAlign.right,
                                  style: appTextStyles.p144008082.copyWith(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              10.w.horizontalSpace,
                              InkWell(
                                onTap: () async {
                                  String myUrl =
                                      'https://www.equicare.com.au/privacy';
                                  if (!await launchUrl(
                                    Uri.parse(myUrl),
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw Exception(
                                        'Could not launch ==>> $myUrl');
                                  }
                                },
                                child: Text(
                                  'Privacy Policy',
                                  textAlign: TextAlign.right,
                                  style: appTextStyles.p144008082.copyWith(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    20.h.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class EquiCareHorseContainerWidget extends StatelessWidget {
  const EquiCareHorseContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 25.w),
      height: MediaQuery.of(context).size.height * 0.33,
      // width: double.maxFinite,
      decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
              image: AssetImage(appImages.loginAndSignupImagePng),
              fit: BoxFit.fitWidth)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(appIcons.horseHeartIconSvg),
              20.w.horizontalSpace,
              Text(
                "EquiCare",
                style: appTextStyles.p26900
                    .copyWith(color: Colors.white, shadows: [
                  const Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(3, 4),
                  ),
                  const Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(3, 4),
                  ),
                ]),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Horse management at your fingertips!',
                  style: appTextStyles.p26900.copyWith(color: Colors.white, fontSize: 22, shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(3, 4),
                    ),
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(3, 4),
                    ),
                  ]),
                ),
                5.h.verticalSpace,
              ],
            ),
          )
        ],
      ),
    );
  }
}
