import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';

class AppDotWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  const AppDotWidget({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size ?? 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? appColors.c1E4475,
      ),
    );
  }
}
