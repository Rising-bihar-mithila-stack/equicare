import 'dart:developer';

import 'package:equicare/common/functions/app_functions_for_subscriptions.dart';
import 'package:equicare/features/subscription/controller/subscription_controller.dart';
import 'package:equicare/repo/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../common/buttons/app_blue_button.dart';
import '../../../common/buttons/app_radio_button.dart';
import '../../../common/text_field/app_text_field.dart';
import '../../../utils/constants/app_constants.dart';

class ChooseYourPlanWidget extends StatefulWidget {
  const ChooseYourPlanWidget({
    super.key,
  });

  @override
  State<ChooseYourPlanWidget> createState() => _ChooseYourPlanWidgetState();
}

class _ChooseYourPlanWidgetState extends State<ChooseYourPlanWidget> {
  final promoCodeController = TextEditingController();
  late SubscriptionController subscriptionController;
  bool isLoading = false;
  Offerings? offerings;
  Offering? offering;
  String? percentDiscount;
  Package? selectedPackageForBuy;
  int? selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() async {
    subscriptionController = Get.put(SubscriptionController());
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        offerings = await Purchases.getOfferings();
        offering = offerings?.current;
        if (context.mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.h.verticalSpace,
        Text(
          "Choose Your Plan",
          style: appTextStyles.p24700313131,
        ),
        Text(
          "You are just one step away from disciplined, fun and easy horse care",
          style: appTextStyles.p164008183,
          textAlign: TextAlign.center,
        ),
        20.h.verticalSpace,
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: offering?.availablePackages.length ?? 0,
          itemBuilder: (context, index) {
            var myProductList = offering?.availablePackages[index];
            return Visibility(
              visible:
                  //
                  // true,
                  isVisible(
                discountPercent: percentDiscount,
                identifier: myProductList?.identifier ?? "",
              ),
              child: InkWell(
                onTap: () async {
                  try {
                    // CustomerInfo customerInfo =
                    //     await Purchases.purchasePackage(myProductList!);
                    // EntitlementInfo? entitlement =
                    //     customerInfo.entitlements.all[entitlementID];
                    // appData.entitlementIsActive =
                    //     entitlement?.isActive ?? false;
                  } catch (e) {
                    print(e);
                  }
                  // Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: !(1 == 1)
                              ? appColors.primaryBlueColor
                              : appColors.cDFDFDF),
                      borderRadius: BorderRadius.circular(14.r)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Row(
                    children: [
                      AppRadioButton(
                        key: UniqueKey(),
                        isSelected: selectedIndex == index,
                        onTap: (p0) {
                          selectedIndex = index;
                          selectedPackageForBuy = myProductList;
                          setState(() {});
                        },
                      ),
                      15.w.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // "1 Month",
                              "${myProductList?.storeProduct.title}",
                              style: appTextStyles.p167003131,
                            ),
                            10.h.verticalSpace,
                            Text(
                              // "14 days free trial, cancel anytime",
                              "${myProductList?.storeProduct.description}",
                              style: appTextStyles.p125008183,
                            )
                          ],
                        ),
                      ),
                      15.w.horizontalSpace,
                      Column(
                        children: [
                          Text(
                            // "390",
                            "${myProductList?.storeProduct.priceString}",
                            // "\$${myProductList?.storeProduct.price.toPrecision(2)}",
                            style: appTextStyles.p167001EBlue,
                          ),
                          10.h.verticalSpace,
                          Text(
                            index == 0
                                ? ''
                                : index == 1
                                    ? 'Save 10%'
                                    : 'Save 16%'
                                        // myProductList?.storeProduct.priceString == '₹2,100.00'?'Save 10%':myProductList?.storeProduct.priceString=='₹3,900.00'?'Save 16%':
                                        // myProductList?.storeProduct.description == '6 Months Full Access'?'Save 10%':myProductList?.storeProduct.description=='1 Year Full Access'?'Save 16%':
                                        "",
                            // "${myProductList?.storeProduct.discounts}",
                            style: appTextStyles.p125008183,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // 20.h.verticalSpace,
        GetBuilder(
            init: subscriptionController,
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: AppTextField(
                      hintText: "Enter Promo Code",
                      textEditingController: promoCodeController,
                      title: "Promo Code",
                    ),
                  ),
                  10.h.horizontalSpace,
                  Flexible(
                    child: Column(
                      children: [
                        30.h.verticalSpace,
                        controller.isLoading
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CircularProgressIndicator(
                                  color: appColors.primaryBlueColor,
                                ),
                              )
                            : AppBlueButton(
                                title: (percentDiscount != null)
                                    ? "Delete"
                                    : "Apply",
                                verticalPadding: 18,
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (percentDiscount == null) {
                                    var per = await controller.useCoupon(
                                        couponCode:
                                            promoCodeController.text.trim(),
                                        redeemTrueOnSubscribe: false,
                                        productName: null);
                                    percentDiscount = per;
                                    if (percentDiscount == "100") {
                                      var res =
                                          await AppFunctionForSubscriptions()
                                              .grantOrRevokeFullAccess();
                                      if (res == true) {
                                        isUserHaveActiveSubscriptionConstant =
                                            true;
                                        Get.toNamed(appRouteNames
                                            .bottomNavigationBarScreen);
                                      }
                                    }
                                  } else {
                                    percentDiscount = null;
                                    promoCodeController.clear();
                                  }
                                  setState(() {});
                                },
                              )
                      ],
                    ),
                  ),
                ],
              );
            }),
        10.h.verticalSpace,
        AppBlueButton(
          title: "Subscribe Now",
          isInactive: isLoading,
          onTap: () async {
            if (selectedPackageForBuy != null) {
              try {
                setState(() {
                  isLoading = true;
                });
                CustomerInfo customerInfo =
                    await Purchases.purchasePackage(selectedPackageForBuy!);
                //
                Purchases.addCustomerInfoUpdateListener(
                  (customerInfo) {
                    log("customerInfo ---> $customerInfo");
                    isUserHaveActiveSubscriptionConstant =
                        customerInfo.activeSubscriptions.isNotEmpty;
                    if (isUserHaveActiveSubscriptionConstant == true) {
                      isUserHaveActiveSubscriptionConstant = true;
                      Get.offAllNamed(appRouteNames.bottomNavigationBarScreen);
                    }
                  },
                );

                //

                //
                setState(() {
                  isLoading = false;
                });
              } catch (e) {
                log("SubscribeNow ---> $e");
                setState(() {
                  isLoading = false;
                });
              }
            }
            isUserHaveActiveSubscriptionConstant = true;
            Get.offAllNamed(appRouteNames.bottomNavigationBarScreen);
          },
        ),
        99.h.verticalSpace,
      ],
    );
  }

  bool isVisible(
      {required String? discountPercent, required String identifier}) {
    if ((discountPercent == null || discountPercent.isEmpty) &&
        (

            // (identifier == "NonRenewingSub1Month" ||
            //       identifier == "NonRenewingSub6Months" ||
            //       identifier == "NonRenewingSubOneYear")
            //       ||
            (identifier == "\$rc_monthly" ||
                    identifier == "\$rc_six_month" ||
                    identifier == "\$rc_annual") ||
                //
                (identifier == "One Month Subscription" ||
                    identifier == "Six Month Subscription" ||
                    identifier == "Yearly Subscription Product"))) {
      return true;
    } else if (discountPercent == "20" // 20 %
        &&
        (

            // (identifier == "NonRenewingSub1Month20Off" ||
            //       identifier == "NonRenewingSub6Months20Off" ||
            //       identifier == "NonRenewingSubOneYear20Off")
            //       ||
            (identifier == "20OffMonth") ||
                (identifier == "One Month Sub 20 off" ||
                    identifier == "6 Month Sub 20% off" ||
                    identifier == "Yearly Sub 20% off"))) {
      return true;
    } else if (discountPercent == "50"
        // 50 %
        &&
        (

            // (identifier == "NonRenewingSub1Month50Off" ||
            //       identifier == "NonRenewingSub6Months50Off" ||
            //       identifier == "NonRenewingSubOneYear50Off") ||

            (identifier == "50OffMonth") ||
                //
                (identifier == "One Month Sub 50% off" ||
                    identifier == "6 Month Sub 50% off" ||
                    identifier == "Yearly Sub 50% off"))) {
      return true;
    } else {
      return false;
    }
  }
}
