import 'package:equicare/features/settings/controller/associated_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../modals/invites_sent_user_modal.dart';

class InvitesSentScreen extends StatefulWidget {
  const InvitesSentScreen({super.key});

  @override
  State<InvitesSentScreen> createState() => _InvitesSentScreenState();
}

class _InvitesSentScreenState extends State<InvitesSentScreen> {
  late AssociatedUsersController associatedUsersController;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    associatedUsersController = Get.find(tag: "associatedUsersController");

    ///  invitesSentList
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Section
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: appColors.primaryBlueColor,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Invites Sent',
                      textAlign: TextAlign.center,
                      style: appTextStyles.p308002E2E,
                    ),
                    SizedBox(width: 0.w), // Fixed-width space if needed
                  ],
                ),
                const AppAppBarShadowWidget(),
                SizedBox(height: 10.h),
              ],
            ),

            // List of Associated Users
            GetBuilder(
                init: associatedUsersController,
                id: "invitesSent",
                builder: (controller) {
                  return

                      //  controller.isLoading.value
                      //     ? Column(
                      //         children: [
                      //           250.h.verticalSpace,
                      //           CircularProgressIndicator(
                      //             color: appColors.primaryBlueColor,
                      //           ),
                      //         ],
                      //       )
                      //     :

                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.invitesSentList.length,
                          itemBuilder: (context, index) {
                            var inviteModal = controller.invitesSentList[index];
                            return InvitesSentCardWidget(
                              inviteModal: inviteModal,
                            );
                          },
                        ),
                      );
                }),
          ],
        ),
      ),
    );
  }
}

class InvitesSentCardWidget extends StatelessWidget {
  final InvitesSentUserModal? inviteModal;

  const InvitesSentCardWidget({super.key, this.inviteModal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: appColors.cCBCDD7.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.06),
            offset: const Offset(0, 6),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            // backgroundImage: AssetImage(appImages.profileDefaultImage),
            backgroundColor: Colors.grey[300],
            minRadius: 26.r,
            child: Icon(
              Icons.person,
              color: appColors.white,
              size: 35.r,
            ),
          ),
          SizedBox(width: 15.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${inviteModal?.toEmail}",
                      // "richardshallos@gmail.com",
                      style: appTextStyles.p16500White
                          .copyWith(color: appColors.cAEB0C3),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "${inviteModal?.status?.capitalizeFirst}",
                      style: appTextStyles.p167003131.copyWith(
                          color: inviteModal?.status?.toLowerCase() == 'sent'
                              ? appColors.c1E4475
                              : inviteModal?.status?.toLowerCase() == 'accepted'
                                  ? appColors.c3DAB48
                                  : inviteModal?.status?.toLowerCase() ==
                                          'rejected'
                                      ? appColors.cEA4335
                                      : null),
                    ),
                  ],
                ),
              ),
              // Icon(
              //   Icons.close,
              //   size: 18,
              //   color: appColors.cADB0C3,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
