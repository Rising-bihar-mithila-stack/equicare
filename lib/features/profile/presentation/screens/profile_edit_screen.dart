import 'dart:io';

import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/drop_downs/app_dropdown.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/profile/controller/profile_controller.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/functions/fun.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../common/widgets/image_select_bottom_sheet_widget.dart';
import '../../../../utils/constants/app_constants.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController dobController;
  late TextEditingController sexController;
  late TextEditingController countryController;
  late ProfileController controller;
  String? selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(ProfileController());
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    dobController = TextEditingController();
    sexController = TextEditingController();
    countryController = TextEditingController();
    firstNameController.text = controller.userData.firstName ?? "";
    lastNameController.text = controller.userData.lastName ?? "";
    dobController.text =
        controller.userData.dateOfBirth?.convertDateFormatToDMYYYY() ?? "";
    sexController.text = controller.userData.gender ?? "";
    countryController.text = controller.userData.country ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    sexController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () =>
          //  controller.isLoading.value
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :

          ModalProgressHUD(
        inAsyncCall: controller.isLoading.value,
        child: GetBuilder<ProfileController>(
          builder: (controller) => SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      'Edit Profile',
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
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Stack(
                              children: [
                                Container(
                                  width: 140.w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    backgroundImage: controller
                                                    .userData.profileImage !=
                                                null &&
                                            selectedImage == null || selectedImage==''
                                        ? NetworkImage(
                                            controller.userData.profileImage ??
                                                "")
                                        : selectedImage != null
                                            ? FileImage(File(selectedImage!))
                                            : AssetImage(
                                                appImages.profileDefaultImage),
                                  ),
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: appColors.cF2F2F2,
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 7,
                                    child: GestureDetector(
                                      onTap: () {
                                        // var pickImage = await getImage(
                                        //     ImageSource.gallery);
                                        // selectedImage =
                                        //     pickImage?.path ?? '';
                                        // controller.update();

                                        // ====================================

                                        showModalBottomSheet(
                                          context: context,
                                          builder: (cnt) {
                                            return ImageSelectBottomSheetWidget(
                                              onCameraTap: () async {
                                                Navigator.pop(cnt);
                                                var pickImage = await getImage(
                                                    ImageSource.camera);
                                                selectedImage =
                                                    pickImage?.path ?? '';
                                                controller.update();
                                              },
                                              onGalleryTap: () async {
                                                Navigator.pop(cnt);
                                                var pickImage = await getImage(
                                                    ImageSource.gallery);
                                                selectedImage =
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
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: AppTextField(
                                  hintText: "Enter Name",
                                  textEditingController: firstNameController,
                                  title: "First Name",
                                )),
                                10.horizontalSpace,
                                Expanded(
                                    child: AppTextField(
                                  hintText: "Enter Name",
                                  textEditingController: lastNameController,
                                  title: "Last Name",
                                )),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.utc(1960),
                                    lastDate: DateTime.now());

                                if (date != null) {
                                  dobController.text =
                                      "${date.day}/${date.month}/${date.year}";
                                }
                              },
                              child: AppTextField(
                                isEnabled: false,
                                hintText: "DD/MM/YYYY",
                                textEditingController: dobController,
                                title: "Date of Birth",
                                suffixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      appIcons.calendarIconSvg,
                                      color: appColors.c1E4475,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            6.h.verticalSpace,
                            AppDropDownWidget(
                              options: const ['Male', 'Female', 'Other'],
                              title: 'Sex',
                              onChanged: (p0) {
                                sexController.text = p0!;
                                controller.update();
                              },
                              selectedTitle: sexController.text.isEmpty
                                  ? null
                                  : sexController.text,
                            ),
                            14.h.verticalSpace,
                            AppDropDownWidget(
                              options: controller.countryList,
                              title: 'Country',
                              onChanged: (p0) {
                                countryController.text = p0!;
                                controller.update();
                              },
                              selectedTitle: countryController.text.isEmpty
                                  ? null
                                  : countryController.text,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: AppBlueButton(
                    title: 'Save Changes',
                    onTap: () async {
                      try {
                        if (firstNameController.text.isEmpty) {
                          myAlertDialog(
                              message: "Please Enter First Name",
                              context: context);
                          // Get.snackbar("Name", "Please enter first name");
                        } else if (lastNameController.text.isEmpty) {
                          myAlertDialog(
                              message: "Please Enter Last Name",
                              context: context);
                          // Get.snackbar("Name", "Please enter last name");
                        } else if (dobController.text.isEmpty) {
                          myAlertDialog(
                              message: "Please Select Date Of Birth",
                              context: context);
                          // Get.snackbar(
                          //     "D-O-B", "Please select date odf birth");
                        } else if (sexController.text.isEmpty) {
                          myAlertDialog(
                              message: "Please Select Sex", context: context);
                          // Get.snackbar("Sex", "Please select sex");
                        } else if (countryController.text.isEmpty) {
                          myAlertDialog(
                              message: "Please Select Country",
                              context: context);
                          // Get.snackbar("Country", "Please select country");
                        } else {
                          if (await controller.updateProfile(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              dob: dobController.text
                                  .convertDateFormatToYYYYMMDD(),
                              sex: sexController.text,
                              country: countryController.text,
                              image: selectedImage)) {
                            Get.back();
                          } else {
                            myAlertDialog(
                                message: "Something Went Wrong",
                                context: context);
                            // Get.snackbar("Error", "Something went wrong");
                          }
                        }
                      } catch (e) {
                        myAlertDialog(message: '$e', context: context);
                        // print("error ==>> $e");
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
