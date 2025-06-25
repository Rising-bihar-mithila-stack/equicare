import 'package:flutter/material.dart';

class AppAppBarShadowWidget extends StatelessWidget {
  const AppAppBarShadowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFF5EEF5)),
        ),
        shadows: [
          BoxShadow(
            color: Color(0xFFF9F5F0),
            blurRadius: 34,
            offset: Offset(0, 14),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }
}
