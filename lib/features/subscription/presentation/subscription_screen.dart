// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/buttons/app_grey_button.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../common/buttons/app_radio_button.dart';
import 'choose_your_plan_widget.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: appColors.primaryBlueColor,
          ),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        20.h.verticalSpace,
                        SvgPicture.asset(appIcons.giftIconSvg),
                        20.h.verticalSpace,
                        Text(
                          "Welcome to EquiCare, the ultimate management platform for horse owners.",
                          style: appTextStyles.p16400DDD9,
                          textAlign: TextAlign.center,
                        ),
                        10.h.verticalSpace,
                        Text(
                          "With each subscription plan, you will receive full access to the following:",
                          style: appTextStyles.p16400DDD9,
                          textAlign: TextAlign.center,
                        ),
                        15.h.verticalSpace,
                        FourMatrixWidget(),
                        15.h.verticalSpace,
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )),
                      child:

                          //  1 == 1
                          //     ? ChooseYourPlanWidget(
                          //         offering: offerings?.current,
                          //       )
                          //     :

                          // GetYourSubscriptionWidget(),

                          //
                          ChooseYourPlanWidget()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class GetYourSubscriptionWidget extends StatelessWidget {
//   const GetYourSubscriptionWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         20.h.verticalSpace,
//         Text(
//           "Get Your Subscription",
//           style: appTextStyles.p24700313131,
//         ),
//         15.h.verticalSpace,
//         AppBlueButton(title: "Choose Your Plan"),
//         //  cF2F2F2
//         10.h.verticalSpace,
//         AppGreyButton(
//           title: "Restore Subscription",
//         ),
//         15.h.verticalSpace,
//         Divider(
//           color: appColors.cEAEAEA,
//         ),
//         15.h.verticalSpace,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Flexible(
//               flex: 2,
//               child: AppTextField(
//                 hintText: "Enter Promocode",
//                 textEditingController: TextEditingController(),
//                 title: "Promocode",
//               ),
//             ),
//             10.h.horizontalSpace,
//             Flexible(
//               child: Column(
//                 children: [
//                   30.h.verticalSpace,
//                   AppBlueButton(
//                     title: "Apply",
//                     verticalPadding: 18,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         10.h.verticalSpace,
//         Text.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                 text: 'Please read our ',
//                 style: appTextStyles.p14400313131,
//               ),
//               TextSpan(
//                 text: 'Terms & Conditions before subscribing',
//                 style: appTextStyles.p144001E44Blue
//                     .copyWith(decoration: TextDecoration.underline),
//               ),
//             ],
//           ),
//         ),
//         60.h.verticalSpace,
//       ],
//     );
//   }
// }

class FourMatrixWidget extends StatelessWidget {
  const FourMatrixWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white54,
                    ),
                    right: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                ),
                child: FourMatrixHelperWidget(
                  title: "Personalised \nCalendar\n",
                  iconPath: appIcons.calendarIconSvg,
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                ),
                child: FourMatrixHelperWidget(
                  title: "Horse Management Categories\n",
                  iconPath: appIcons.hoofIconSvg,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                ),
                child: FourMatrixHelperWidget(
                  title: "Horse Stable\n",
                  iconPath: appIcons.horseIconSvg,
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                // width: double.maxFinite,
                child: FourMatrixHelperWidget(
                  title: "Contacts\n",
                  iconPath: appIcons.contactsIconSvg,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FourMatrixHelperWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  const FourMatrixHelperWidget(
      {super.key, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(iconPath),
        10.h.verticalSpace,
        Text(
          title,
          style: appTextStyles.p16400White,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
