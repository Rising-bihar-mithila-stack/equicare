import 'package:equicare/features/profile/models/profile_model.dart';
import 'package:equicare/features/settings/controller/associated_users_controller.dart';
import 'package:equicare/features/settings/modals/sub_user_modal.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../profile/presentation/widgets/profile_picture_widget.dart';

class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SubUserModal? subUserModal = Get.arguments["subUserModal"];
    return Scaffold(
      backgroundColor: appColors.c1E4475,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 180.h),
            decoration: BoxDecoration(
              color: appColors.cFDFDFD,
              // color: Colors.amber,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(100, 50),
                topRight: Radius.elliptical(100, 50),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  color: appColors.cF2F2F2,
                                )),
                          ],
                        ),
                        20.h.verticalSpace,
                        ProfilePictureWidget(),
                        8.h.verticalSpace,
                        Text(
                            "${subUserModal?.firstName} ${subUserModal?.lastName}",
                            style: appTextStyles.p287003131),
                        Text("${subUserModal?.email}",
                            style: appTextStyles.p14500818393),
                        18.h.verticalSpace,
                        ProfileInfoWidget(
                          userData: ProfileModel(
                              dateOfBirth: subUserModal?.dateOfBirth,
                              country: subUserModal?.country),
                        ),
                      ],
                    )),
                GetBuilder<AssociatedUsersController>(
                    init: Get.put(AssociatedUsersController()),
                    builder: (controller) {
                      return controller.isLoading.value
                          ? CircularProgressIndicator(
                              color: appColors.primaryBlueColor,
                            )
                          : InkWell(
                              onTap: () async {
                                var res = await controller.deleteSubUser(
                                    subUserId: subUserModal?.id ?? 0);
                                if (res == true) {
                                  Get.back();
                                  // Get.snackbar(
                                  //     "Success", "User removed successfully.");
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: appColors.cFBEAE9,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: appColors.cEA4335,
                                    ),
                                    5.horizontalSpace,
                                    Text(
                                      'Remove User',
                                      style: appTextStyles.p165003DABGreen
                                          .copyWith(color: appColors.cEA4335),
                                    )
                                  ],
                                ),
                              ),
                            );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
