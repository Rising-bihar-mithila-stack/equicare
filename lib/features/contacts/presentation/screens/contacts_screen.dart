import 'package:cached_network_image/cached_network_image.dart';
import 'package:equicare/features/contacts/controller/contact_controller.dart';
import 'package:equicare/features/contacts/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../profile/presentation/widgets/profile_picture_widget.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late ContactController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(ContactController());
    controller.getAllContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () => Get.toNamed(appRouteNames.addAndEditContactScreen),
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColors.primaryBlueColor,
            ),
            child: SvgPicture.asset(
              appIcons.addIconSvg,
              color: appColors.white,
            ),
          ),
        ),
        body: Obx(
          () => 
          
          // controller.isLoading.value
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : 
              
            ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
                child: GetBuilder<ContactController>(
                    builder: (controller) => SafeArea(
                        child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Contacts',
                                textAlign: TextAlign.center,
                                style: appTextStyles.p308002E2E,
                              ),
                            ),
                          ],
                        ),
                        4.h.verticalSpace,
                        AppAppBarShadowWidget(),
                        !controller.contactList.isEmpty
                            ? Expanded(
                                child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    20.h.verticalSpace,
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.contactList.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return ContactsCardWidget(
                                            contactModel:
                                                controller.contactList[index],
                                          );
                                        })
                                  ],
                                ),
                              ))
                            : Expanded(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    appImages.emptyContactPng,
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    "You do not have any contacts",
                                  ),
                                ],
                              ))
                      ],
                    )),
                  ),
              ),
        ));
  }
}

class ContactsCardWidget extends StatelessWidget {
  final ContactModel contactModel;

  const ContactsCardWidget({super.key, required this.contactModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
      ).copyWith(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w)
          .copyWith(right: 0),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: appColors.cCBCDD7.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.06),
            offset: const Offset(0, 6),
            spreadRadius: 0,
            blurRadius: 18,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(appRouteNames.specificContactDetailScreen,
              arguments: contactModel.id);
        },
        child: Row(
          children: [
            Container(
              width: 95,
              height: 95,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: appColors.white,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(110),
                child: CachedNetworkImage(
                  imageUrl: contactModel.profile ?? "",
                  placeholder: (context, url) => ShimmerEffect(
                    width: 100,
                    height: 100,
                  ),
                  errorWidget: (context, url, error) {
                    return ShimmerEffect(
                      width: 100,
                      height: 100,
                    );
                    // return Image.asset(appIcons.userPng);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            15.w.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width:150,
                    child: Text(
                      contactModel.fullName ?? "",
                      style: appTextStyles.p18500313131,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 6, bottom: 6, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          contactModel.profession ?? "",
                          style: appTextStyles.p165001E4475,
                        ),
                        Icon(
                          size: 18,
                          Icons.arrow_forward_ios,
                          color: appColors.cADB0C3,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    contactModel.phoneNo ?? "+1 45845 47856",
                    style: appTextStyles.p14500AEB0C3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
