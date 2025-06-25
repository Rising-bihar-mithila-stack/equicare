import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';

class ProfileDetailsInfoCardWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool? isDividerVisible;
  const ProfileDetailsInfoCardWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.isDividerVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                title,
                style: appTextStyles.p14500AEB0C3,
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                subTitle,
                style: appTextStyles.p167003131,
              ),
            ),
          ],
        ),
        10.h.verticalSpace,
        Visibility(
          visible: isDividerVisible ?? true,
          child: Divider(
            color: appColors.cE5E7F4,
          ),
        )
      ],
    );
  }
}
