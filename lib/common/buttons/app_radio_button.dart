import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';

class AppRadioButton extends StatefulWidget {
  final void Function(bool) onTap;
  final double? size;
  final bool? isSelected;
  const AppRadioButton(
      {super.key, required this.onTap, this.size, this.isSelected});

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  bool isSelected = true;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    isSelected = widget.isSelected ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // isSelected = !isSelected;
          widget.onTap(isSelected);
        });
      },
      child: Container(
        padding: EdgeInsets.all(widget.size ?? 9),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? appColors.primaryBlueColor : appColors.cDFDFDF,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(widget.size ?? 9),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? appColors.primaryBlueColor : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
