import 'dart:io';

import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/drop_downs/app_dropdown.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/common/widgets/image_select_bottom_sheet_widget.dart';
import 'package:equicare/features/auth/controller/auth_controller.dart';
import 'package:equicare/features/auth/models/country_model.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/functions/fun.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late AuthController controller;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    controller = Get.put(AuthController());
    // Map<String, dynamic>? args = Get.arguments;
    // controller.emailController.text = args?["email"];
    // controller.passwordController.text = args?["password"];
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
                Expanded(
                  child: SingleChildScrollView(
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
                                  color: appColors.c1E4475,
                                )),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    'Create Account',
                                    textAlign: TextAlign.center,
                                    style: appTextStyles.p308002E2E,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      'Please enter your details to create account',
                                      textAlign: TextAlign.center,
                                      style: appTextStyles.p16400AEB0C3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            )
                          ],
                        ),
                        10.h.verticalSpace,
                        const AppAppBarShadowWidget(),
                        12.h.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 135.w,
                                    height: 145.h,
                                    decoration: controller
                                            .selectedImage.isNotEmpty
                                        ? BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(
                                                  File(
                                                    controller.selectedImage,
                                                  ),
                                                ),
                                                fit: BoxFit.cover),
                                            shape: BoxShape.circle,
                                            color: appColors.cF2F2F2,
                                          )
                                        : BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: appColors.cF2F2F2,
                                          ),
                                    child: controller.selectedImage.isEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              controller.selectedImage.isEmpty
                                                  ? SvgPicture.asset(
                                                      appIcons.personIconSvg,
                                                      color: appColors.cCBCDD7,
                                                      width: 55.w,
                                                      height: 55.h,
                                                    )
                                                  : Image.file(
                                                      File(controller
                                                          .selectedImage),
                                                      fit: BoxFit.contain,
                                                    ),
                                            ],
                                          )
                                        : null,
                                  ),
                                  Positioned(
                                      right: 0,
                                      bottom: 3,
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (cnt) {
                                              return ImageSelectBottomSheetWidget(
                                                onCameraTap: () async {
                                                  Navigator.pop(cnt);
                                                  var pickImage =
                                                      await getImage(
                                                          ImageSource.camera);
                                                  controller.selectedImage =
                                                      pickImage?.path ?? '';
                                                  controller.update();
                                                },
                                                onGalleryTap: () async {
                                                  Navigator.pop(cnt);
                                                  var pickImage =
                                                      await getImage(
                                                          ImageSource.gallery);
                                                  controller.selectedImage =
                                                      pickImage?.path ?? '';
                                                  controller.update();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(13),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: appColors.primaryBlueColor,
                                          ),
                                          child: SvgPicture.asset(
                                              appIcons.addIconSvg,
                                              color: appColors.white,
                                              height: 13.h,
                                              width: 13.w),
                                        ),
                                      ))
                                ],
                              ),
                              10.h.verticalSpace,
                              Row(
                                children: [
                                  Flexible(
                                    child: AppTextField(
                                        hintText: "Enter First Name",
                                        textEditingController:
                                            controller.firstNameController,
                                        title: "First Name"),
                                  ),
                                  15.w.horizontalSpace,
                                  Flexible(
                                    child: AppTextField(
                                        hintText: "Enter Last Name",
                                        textEditingController:
                                            controller.lastNameController,
                                        title: "Last Name"),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  var date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime.utc(1901),
                                      lastDate: DateTime.now());

                                  if (date != null) {
                                    controller.dateController.text =
                                        "${date.day}/${date.month}/${date.year}";
                                  }
                                },
                                child: AppTextField(
                                  isEnabled: false,
                                  hintText: "DD/MM/YYYY",
                                  textEditingController:
                                      controller.dateController,
                                  title: "Date Of Birth",
                                  suffixIcon: IconButton(
                                    onPressed: () async {},
                                    icon: Icon(
                                      Icons.calendar_month,
                                      color: appColors.primaryBlueColor,
                                    ),
                                  ),
                                ),
                              ),
                              AppDropDownWidget(
                                title: "Sex",
                                selectedTitle: controller.sexController.isEmpty
                                    ? null
                                    : controller.sexController,
                                options: ["Male", "Female", "Other"],
                                onChanged: (p0) {
                                  controller.sexController = p0 ?? "";
                                  controller.update();
                                },
                              ),
                              10.h.verticalSpace,
                              AppDropDownWidget(
                                title: "Country",
                                selectedTitle:
                                    controller.countryController.isEmpty
                                        ? null
                                        : controller.countryController,
                                options: const [],
                                items: controller.countryList.map(
                                  (e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e.value ?? "N/A"),
                                    );
                                  },
                                ).toList(),
                                onChanged: (p0) {
                                  if (p0 is CountryModel) {
                                    controller.countryController =
                                        p0.value ?? "";
                                    controller.update();
                                    //   controller.timeZoneList.clear();
                                    //   controller
                                    //       .getCountryTimeZoneById(p0.id ?? 0);
                                    //   controller.timeZoneController = '';
                                  }
                                },
                              ),
                              10.h.verticalSpace,
                              // AppDropDownWidget(
                              //   key: UniqueKey(),
                              //   selectedTitle:
                              //       controller.timeZoneController.isEmpty
                              //           ? null
                              //           : controller.timeZoneController,
                              //   title: "Time Zone",
                              //   options: controller.timeZoneList
                              //       .map((e) => e.value.toString())
                              //       .toList(),
                              //   onChanged: (p0) {
                              //     controller.timeZoneController =
                              //         p0.toString() ?? "";
                              //     controller.update();
                              //   },
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: AppBlueButton(
                            title: "Create Account",
                            onTap: () async {
                              if (controller.firstNameController.text.isEmpty) {
                                myAlertDialog(
                                    context: context,
                                    message: 'Please Enter Your First Name');

                                // Get.snackbar(
                                //     'Email', 'please enter your first name');
                              } else if (controller
                                  .lastNameController.text.isEmpty) {
                                myAlertDialog(
                                    context: context,
                                    message: 'Please Enter Your Last Name');

                                // Get.snackbar(
                                //     'Password', 'Pleas enter your last name');
                              } else if (controller
                                  .dateController.text.isEmpty) {
                                myAlertDialog(
                                    context: context,
                                    message: 'Please Select Your Date Of Birth');

                                // Get.snackbar('Date', 'Pleas your date of birth');
                              } else if (controller.sexController.isEmpty) {
                                myAlertDialog(
                                    context: context,
                                    message: 'Please Select Your Sex');

                                // Get.snackbar('Sex', 'Select your sex');
                              } else if (controller.countryController.isEmpty) {
                                myAlertDialog(
                                    context: context,
                                    message: 'Please Select Your Country');

                                // Get.snackbar('Country', 'Select your country');
                              }
                              //  else if (controller
                              //     .timeZoneController.isEmpty) {
                              //   myAlertDialog(
                              //       context: context,
                              //       message: 'Select Your Country Time Zone');

                              //   // Get.snackbar('Country', 'Select your country');
                              // }
                              else {
                                if (await controller.createAccount()) {
                                  // Get.snackbar(
                                  //     'Message', 'You Are Registered Successfully');
                                  Get.offAllNamed(appRouteNames.loginScreen);
                                } else {
                                  myAlertDialog(
                                      context: context,
                                      message: 'Something Went Wrong');
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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

myAlertDialog({required String message, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: appColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Alert",
                style: appTextStyles.p167003131,
              ),
              10.verticalSpace,
              Text(
                "$message",
              ),
              10.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Text('    OK'),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

void showMyDialogWithoutContext(String e) {
  Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Alert",
                        style: appTextStyles.p167003131,
                      ),
                      10.verticalSpace,
                      Text(
                        "$e",
                      ),
                      10.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Text('OK'),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
