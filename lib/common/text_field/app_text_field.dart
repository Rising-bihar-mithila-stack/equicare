import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final bool isPasswordField;
  final bool? isEnabled;
  final Key? formKey;
  final TextInputType? keyboardType;
  final bool isObsecure;
  final void Function()? onPasswordFieldClicked;
  final Widget? suffixIcon;
  final int? maxLines;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged; // Add this line
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.hintText,
    this.validator,
    required this.textEditingController,
    required this.title,
    this.isPasswordField = false,
    this.isObsecure = false,
    this.onPasswordFieldClicked,
    this.formKey,
    this.maxLines,
    this.suffixIcon,
    this.keyboardType,
    this.isEnabled,
    this.onFieldSubmitted,
    this.onChanged, // Include this line
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title.isNotEmpty,
            child: Text(
              " $title",
              style: appTextStyles.p14400313131,
            ),
          ),
          10.h.verticalSpace,
          TextFormField(
            inputFormatters: inputFormatters,
            controller: textEditingController,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged, // Add this line to handle changes
            enabled: isEnabled,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: appTextStyles.p16400AEB0C3,
            keyboardType: keyboardType,
            validator: validator,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              suffixIcon: isPasswordField
                  ? Padding(
                padding: const EdgeInsets.only(right: 18),
                child: InkWell(
                  radius: 5,
                  onTap: onPasswordFieldClicked,
                  child: isObsecure
                      ? Icon(
                    Icons.visibility,
                    color: appColors.cDFDFDF,
                  )
                      : Icon(
                    Icons.visibility_off,
                    color: appColors.cDFDFDF,
                  ),
                ),
              )
                  : suffixIcon,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: appColors.cDFDFDF,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: appColors.cDFDFDF,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                borderSide: BorderSide(
                  width: 1,
                  color: appColors.c1E4475,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: appColors.cDFDFDF,
                ),
              ),
              hintText: " $hintText",
              hintStyle: appTextStyles.p16400ADB,
            ),
            cursorColor: appColors.c1E4475,
            obscureText: isObsecure,
          ),
        ],
      ),
    );
  }
}
