import 'package:equicare/features/settings/modals/sub_user_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_constants.dart';

class AssociatedUsersCardWidget extends StatelessWidget {
  final SubUserModal? subUserModal;
  final void Function() onBack;
  const AssociatedUsersCardWidget(
      {super.key, this.subUserModal, required this.onBack});

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
      child: InkWell(
        onTap: () {
          Get.toNamed(appRouteNames.connectionsScreen,
              arguments: {"subUserModal": subUserModal})?.then(
            (value) {
              onBack();
            },
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black12,
              backgroundImage: AssetImage(appImages.profileDefaultImage),
              minRadius: 26.r,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${subUserModal?.firstName} ${subUserModal?.lastName}",
                          style: appTextStyles.p18500313131,
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          "${subUserModal?.email}",
                          style: appTextStyles.p165001E4475.copyWith(
                            color: appColors.cAEB0C3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: appColors.cADB0C3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
