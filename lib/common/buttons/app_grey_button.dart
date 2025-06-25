import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';

class AppGreyButton extends StatelessWidget {
  final void Function()? onTap;
  final bool? isInactive;
  final String title;

  const AppGreyButton({
    super.key,
    this.onTap,
    this.isInactive,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isInactive == true ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: appColors.cF2F2F2.withOpacity(isInactive == true ? 0.4 : 1),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isInactive == true
              ? const [
                  BoxShadow(
                    color: Color(0x1E000000),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: -1,
                  ),
                ]
              : null,
        ),
        child: FittedBox(
          child: Text(
            title,
            style: appTextStyles.p165001E4475,
          ),
        ),
      ),
    );
  }
}
