import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/controller/auth_controller.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/buttons/app_blue_button.dart';
import '../../../../common/validator/validator.dart';
import 'create_account_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = true;
  late AuthController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller =
        Get.put(AuthController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AuthController>(
          init: controller,
          id: 'authController',
          builder: (controller) => ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EquiCareHorseContainerWidget(),
                      20.h.verticalSpace,
                      Text(
                        'Sign Up',
                        style: appTextStyles.p308002E2E,
                      ),
                      Text(
                        'Please enter your details to login',
                        style: appTextStyles.p16400ADB,
                      ),
                      AppTextField(
                        hintText: "Enter Email",
                        textEditingController: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        title: "Email",
                        validator: (p0) {
                          return emailValidator(p0);
                        },
                      ),
                      AppTextField(
                        hintText: "Enter Password",
                        textEditingController:
                        controller.passwordController,
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
                      15.h.verticalSpace,
                      AppBlueButton(
                        title: "Sign Up",
                        onTap: () async {
                          if (controller.emailController.text.isEmpty) {
                            myAlertDialog(
                                message: 'Please Enter Your Email',
                                context: context);

                            // Get.snackbar(
                            //     'Email', 'please enter your email');
                          } else if (controller
                              .passwordController.text.isEmpty) {
                            myAlertDialog(
                                message: 'Please Enter Your Password',
                                context: context);

                            // Get.snackbar(
                            //     'Password', 'Pleas enter your password');
                          }else if (controller
                              .passwordController.text.length <=4) {
                            myAlertDialog(
                                message: 'The password must be at least 5 characters.',
                                context: context);

                            // Get.snackbar(
                            //     'Password', 'Pleas enter your password');
                          } else if (validateEmail(
                              controller.emailController.text)) {
                            if(!await controller.isEmailAllReadExist()){
                              Get.toNamed(appRouteNames.createAccountScreen);
                            }else{
                              myAlertDialog(
                                  message: 'Email Already Exist',
                                  context: context);
                            }
                          } else {
                            myAlertDialog(
                                message: 'Enter Valid Email',
                                context: context);
                            // Get.snackbar(
                            //     'Email', 'Enter valid email & password');
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
                                Get.offAndToNamed(
                                    appRouteNames.loginScreen);
                              },
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Already Have An Account? ',
                                      style: appTextStyles.p16400313131,
                                    ),
                                    TextSpan(
                                      text: 'Login',
                                      style: appTextStyles.p165001E4475
                                          .copyWith(
                                          decoration:
                                          TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            20.h.verticalSpace,
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
                                    style: appTextStyles.p144008082
                                        .copyWith(
                                        decoration:
                                        TextDecoration.underline),
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
                                    style: appTextStyles.p144008082
                                        .copyWith(
                                        decoration:
                                        TextDecoration.underline),
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
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
              image: AssetImage(appImages.loginAndSignupImagePng), fit: BoxFit.cover)),
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
                style: appTextStyles.p26900.copyWith(color: Colors.white).copyWith(
                    shadows: [
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
                    ]
                ),
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
                  style: appTextStyles.p26900.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                      shadows: [
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
                      ]
                  ),
                ),
                5.h.verticalSpace,
                // Text(
                //   'Lorem Ispum Is A Dummy Text',
                //   style: appTextStyles.p16500.copyWith(color: Colors.white),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
