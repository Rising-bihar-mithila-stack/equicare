import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:equicare/common/functions/fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/widgets/image_select_bottom_sheet_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../controller/profile_controller.dart';

class ProfilePictureWidget extends StatelessWidget {
  ProfileController? controller;
  ProfilePictureWidget({super.key, this.controller});

  XFile? bgImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  height: 180,
                  color: Colors.white38,
                  child: bgImage == null
                      ? CachedNetworkImage(
                    imageUrl: controller?.userData.backgroundImage ?? "",
                    placeholder: (context, url) => ShimmerEffect(
                      width: double.maxFinite,
                      height: 180,
                    ),
                    errorWidget: (context, url, error) => ShimmerEffect(
                      width: double.maxFinite,
                      height: 180,
                    ),
                    //     Image.asset(
                    //   appImages.defaultProfileImageBg,
                    //   width: double.maxFinite,
                    //   fit: BoxFit.cover,
                    // ),
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  )
                      : Image.file(
                    File(bgImage?.path ?? ""),
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              60.verticalSpace,
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (cnt) {
                  return ImageSelectBottomSheetWidget(
                    onCameraTap: () async {
                      Navigator.pop(cnt);
                      bgImage = await getImage(ImageSource.gallery);
                      if (bgImage != null) {
                        controller?.update();
                        controller?.updateProfileBgImage(
                             bgImage: bgImage?.path ?? "");
                      }
                    },
                    onGalleryTap: () async {
                      Navigator.pop(cnt);
                      bgImage = await getImage(ImageSource.gallery);
                      if (bgImage != null) {
                        controller?.update();
                        controller?.updateProfileBgImage(bgImage:
                            bgImage?.path ?? "");
                      }
                    },
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: appColors.black.withOpacity(0.24),
                shape: const CircleBorder(),
              ),
              child: SvgPicture.asset(appIcons.cameraIconSvg),
            ),
          ),
        ),
        GestureDetector(
          onTap:(){
            showImageViewer(
              context,
              NetworkImage(controller?.userData.profileImage??''),
              doubleTapZoomable: true,
            );
          },
          child: Container(
            width: 140,
            height: 140,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: appColors.white,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(110),
              child: CachedNetworkImage(
                imageUrl: controller?.userData.profileImage ?? "",
                placeholder: (context, url) => ShimmerEffect(
                  width: 140,
                  height: 140,
                ),
                errorWidget: (context, url, error) {
                  return ShimmerEffect(
                    width: 140,
                    height: 140,
                  );
                  // return Image.asset(appIcons.userPng);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  final double width;
  final double height;

  ShimmerEffect({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
