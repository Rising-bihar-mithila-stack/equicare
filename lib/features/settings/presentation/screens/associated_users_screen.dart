import 'package:equicare/features/settings/controller/associated_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../widgets/associated_user_card_widget.dart';

class AssociatedUsersScreen extends StatefulWidget {
  const AssociatedUsersScreen({super.key});

  @override
  State<AssociatedUsersScreen> createState() => _AssociatedUsersScreenState();
}

class _AssociatedUsersScreenState extends State<AssociatedUsersScreen> {
  late AssociatedUsersController associatedUsersController;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    associatedUsersController = Get.put(
      AssociatedUsersController(),
      permanent: true,
      tag: "associatedUsersController",
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // associatedUsersController.getInvitedUsers();
        // getSubUsers
        getData();
      },
    );
  }

  Future<void> getData() async {
    Future.wait([
      associatedUsersController.getInvitedUsers(),
      associatedUsersController.getSubUsers(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App Bar Section
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
                  Expanded(
                    child: Text(
                      'Associated Users',
                      textAlign: TextAlign.center,
                      style: appTextStyles.p308002E2E,
                    ),
                  ),
                  SizedBox(width: 40.w), // Fixed-width space if needed
                ],
              ),
              const AppAppBarShadowWidget(),
              SizedBox(height: 20.h),
          
              // List of Associated Users
              InkWell(
                onTap: () {
                  Get.toNamed(appRouteNames.invitesSentScreen)?.then(
                    (value) {
                      getData();
                    },
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 23.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder(
                          init: associatedUsersController,
                          id: "invitesSent",
                          builder: (controller) {
                            return RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 42),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Invites Sent ',
                                      style: appTextStyles.p18500313131),
                                  TextSpan(
                                      text:
                                          '(${controller.invitesSentList.length})',
                                      // text: '(4)',
                                      style: appTextStyles.p167001EBlue),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            );
                          }),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: appColors.c1E4475,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              GetBuilder(
                  init: associatedUsersController,
                  id: "subUsers",
                  builder: (controller) {
                    return ListView.builder(
                          itemCount: controller.subUsersList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var subUser = controller.subUsersList[index];
                            return AssociatedUsersCardWidget(
                              subUserModal: subUser,
                              onBack: () {
                                associatedUsersController.getSubUsers();
                              },
                            );
                          },
                        );
                  }),
              // Invite Button
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          height: 85,
          child: GestureDetector(
            onTap: () => Get.toNamed(appRouteNames.inviteUserScreen)?.then(
                  (value) {
                getData();
              },
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColors.cF2F2F2,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                '+ Invite a User',
                style: appTextStyles.p165003DABGreen.copyWith(
                  color: appColors.c1E4475,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
