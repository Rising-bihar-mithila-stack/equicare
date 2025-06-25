import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/features/profile/presentation/widgets/profile_picture_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/home/controllers/home_controller.dart';
import '../../utils/constants/app_constants.dart';

class AppCarouselWidget extends StatelessWidget {
  final HomeController homeController;
  const AppCarouselWidget({
    super.key,
    required this.homeController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: homeController,
        builder: (controller) {
          return SizedBox(
            height: 260,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                aspectRatio: 1.12,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: false,
              ),
              items: [
                ...controller.birthdayWidget,
                CoreTipCarouselWidget(),
              ],
            ),
          );
        });
  }
}

// =========================================================

class CarouselContainerWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  const CarouselContainerWidget({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff000000).withOpacity(0.06),
                offset: const Offset(0, 6),
                spreadRadius: 0,
                blurRadius: 22,
              )
            ]),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: imageUrl == null
                        ? Image.asset(
                            appImages.horseImageJpg,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl ?? "",
                            errorWidget: (context, url, error) => Image.asset(
                              appImages.horseImageJpg,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.cake_outlined,
                    size: 30,
                    color: appColors.primaryBlueColor,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Happy Birthday",
                      style: appTextStyles.p165001E4475,
                    ),
                    Text(
                      // "Vinnie",
                      name,
                      style: appTextStyles.p26500313131,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================

class CoreTipCarouselWidget extends StatelessWidget {
  CoreTipCarouselWidget({super.key});

  String? shareText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        margin: EdgeInsets.only(bottom: 19),
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.05),
              offset: const Offset(0, 6),
              spreadRadius: 0,
              blurRadius: 22,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(appIcons.careTipIconSvg),
                15.w.horizontalSpace,
                Text(
                  "Care Tip",
                  style: appTextStyles.p207001EBlue,
                ),
              ],
            ),
            9.verticalSpace,
            Divider(
              color: appColors.cE9EBF8,
            ),
            9.verticalSpace,
            SizedBox(
              height: 95,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: getCareTips(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // return const Center(
                      //   // child:   CircularProgressIndicator(),
                      //   child: LinearProgressIndicator(),
                      //   // child: SizedBox(height: 50,child: LinearProgressIndicator(),),
                      // );
                      return ClipRRect(
                        child: ShimmerEffect(
                          width: double.infinity,
                          height: 80,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      );
                    } else {
                      shareText = snapshot.data;
                      return Text(
                        snapshot.data ?? "",
                        // maxLines: 5,
                        style: appTextStyles.p144008183,
                        // overflow: TextOverflow.ellipsis,
                      );
                    }
                  },
                ),
              ),
            ),
            0.verticalSpace,
            SizedBox(
              height: 55,
              width: 180,
              child: AppBlueButton(
                title: "",
                verticalPadding: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                      size: 30,
                      color: appColors.white,
                    ),
                    10.w.horizontalSpace,
                    Text(
                      "Share The Tip",
                      style: appTextStyles.p16500White,
                    ),
                  ],
                ),
                onTap: () {
                  Share.share(shareText ?? "Care tips");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
