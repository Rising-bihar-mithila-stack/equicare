import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';

class AppDropDownWidget extends StatelessWidget {
  final List<DropdownMenuItem>? items;
  final List<String> options;

  final dynamic value;
  final String? title;
  final String? selectedTitle;

  // final String hintText;
  final void Function(dynamic)? onChanged;
  final bool? isLoading;
  const AppDropDownWidget({
    super.key,
    this.items,
    this.title,
    this.value,
    this.isLoading,
    // required this.hintText,
    this.onChanged,
    required this.options,
    this.selectedTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title != null,
            child: Text(
              " $title",
              // style: AppStyles().mont14500DarkGrey,
            ),
          ),
          const SizedBox(height: 10),
          // ====================
          DropdownButtonHideUnderline(

            child: DropdownButton2(
              
              isExpanded: true,
              hint: Text(
                selectedTitle ?? 'Please Select',
                style: appTextStyles.p16400ADB.copyWith(
                    color: selectedTitle != null ? Colors.black : null),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              items: items ??
                  options
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text("$e")),
                      )
                      .toList(),
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.only(left: 0, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Color(0xffDFDFDF),
                  ),
                  color: Colors.white,
                ),
              ),
              iconStyleData: const IconStyleData(
                openMenuIcon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Color(0xffDFDFDF),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Color(0xffDFDFDF),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                offset: const Offset(0, -10),
                // padding: EdgeInsets.all(9),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 55,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
          // ========================
        ],
      ),
    );
  }
}





// class AppDropDownWidget extends StatelessWidget {
//   const AppDropDownWidget({
//     super.key,
//     this.onChanged,
//     required this.options,
//     required this.title,
//     this.items,
//     this.selectedTitle,
//   });
//   final String title;
  // final String? selectedTitle;
//   final void Function(dynamic)? onChanged;
//   final List<String> options;
//   final List<DropdownMenuItem<dynamic>>? items;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Visibility(
//           visible: title.isNotEmpty,
//           child: Text(
//             " $title",
//             style: appTextStyles.p14400313131,
//           ),
//         ),
//         10.h.verticalSpace,
//         DropdownButtonFormField(
//           isExpanded: true,
//           decoration: InputDecoration(
//             fillColor: Colors.white,
//             filled: true,
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.r),
//               borderSide: BorderSide(
//                 color: appColors.cDFDFDF,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.r),
//               borderSide: BorderSide(
//                 color: appColors.cDFDFDF,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(16.r)),
//               borderSide: BorderSide(
//                 width: 1,
//                 color: appColors.cDFDFDF,
//               ),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.r),
//               borderSide: BorderSide(
//                 color: appColors.cDFDFDF,
//               ),
//             ),
//           ),
//           items: items ??
//               options.map((item) {
//                 return DropdownMenuItem(
//                   value: item,
//                   child: Text(item),
//                 );
//               }).toList(),
          // hint: Text(
          //   selectedTitle ?? ' Please Select',
          //   style: appTextStyles.p16400ADB
          //       .copyWith(color: selectedTitle != null ? Colors.black : null),
          //   textAlign: TextAlign.center,
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          // ),
//           dropdownColor: Colors.white,
//           onChanged: onChanged,
//           menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
//         ),
//       ],
//     );
//   }
// }
