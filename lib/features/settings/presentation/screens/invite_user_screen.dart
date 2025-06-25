import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/common/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/buttons/app_blue_button.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../controller/associated_users_controller.dart';

class InviteUserScreen extends StatefulWidget {
  const InviteUserScreen({super.key});

  @override
  State<InviteUserScreen> createState() => _InviteUserScreenState();
}

class _InviteUserScreenState extends State<InviteUserScreen> {
  late AssociatedUsersController associatedUsersController;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    associatedUsersController = Get.find(tag: "associatedUsersController");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              16.verticalSpace,
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
                    'Invite a User',
                    textAlign: TextAlign.center,
                    style: appTextStyles.p308002E2E,
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
              10.h.verticalSpace,
              const AppAppBarShadowWidget(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    AppTextField(
                        hintText: ' Enter Email',
                        textEditingController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                        title: 'Email'),
                    5.h.verticalSpace,
                    Text(
                      'Please provide email which you want to be associated with your account to share the stable. This user can view your stable and events but cannot add horses or edit a horse’s profile.',
                      style: appTextStyles.p164008183,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
            child: Obx(
              () {
                return associatedUsersController.isLoading.value
                    ? CircularProgressIndicator(
                        color: appColors.primaryBlueColor,
                      )
                    : AppBlueButton(
                        title: 'Send Invite',
                        onTap: () async {
                          var isMailValid =
                              emailValidator(emailController.text.trim());
                          if (isMailValid == null) {
                            var res = await associatedUsersController
                                .sendInvitationMail(
                                    email: emailController.text.trim());
                            if (res == true) {
                              Get.back();
                              // Get.snackbar(
                              //     "Success", "Invitation sent successfully.");
                            }
                          }
                        },
                      );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
