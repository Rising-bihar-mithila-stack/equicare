// import 'package:equicare/common/buttons/app_blue_button.dart';
// import 'package:equicare/common/text_field/app_text_field.dart';
// import 'package:equicare/utils/constants/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../common/shadows/app_appbar_shadow_widget.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController rePasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 10.w.horizontalSpace,
//                 IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: appColors.primaryBlueColor,
//                       size: 30,
//                     )),
//                 15.w.horizontalSpace,
//                 Text(
//                   'Change Password',
//                   textAlign: TextAlign.center,
//                   style: appTextStyles.p308002E2E,
//                 ),
//               ],
//             ),
//             20.h.verticalSpace,
//             const AppAppBarShadowWidget(),
//             20.h.verticalSpace,
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15.w),
//                 child: Column(
//                   children: [
//                     AppTextField(
//                         hintText: "Enter New Password",
//                         textEditingController: passwordController,
//                         title: "New Password"),
//                     AppTextField(
//                         hintText: "Enter New Password",
//                         textEditingController: rePasswordController,
//                         title: "Re-Type New Password"),
//                     const Spacer(),
//                     AppBlueButton(
//                       title: "Change",
//                       onTap: () {
//                         Get.toNamed(appRouteNames.loginScreen);
//                       },
//                     ),
//                     10.h.verticalSpace,
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     passwordController.dispose();
//     rePasswordController.dispose();
//     super.dispose();
//   }
// }
