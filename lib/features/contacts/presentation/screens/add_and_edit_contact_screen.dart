import 'dart:async';
import 'dart:io';

import 'package:equicare/common/validator/validator.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/contacts/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart'as nativeContact;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:searchfield/searchfield.dart';
// import 'package:flutter_contacts/contact.dart';
import '../../../../common/buttons/app_blue_button.dart';
import '../../../../common/buttons/app_grey_button.dart';
import '../../../../common/drop_downs/app_dropdown.dart';
import '../../../../common/functions/fun.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../common/text_field/app_text_field.dart';
import '../../../../common/widgets/image_select_bottom_sheet_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../model/contact_model.dart';

class AddAndEditContactScreen extends StatefulWidget {
  @override
  State<AddAndEditContactScreen> createState() =>
      _AddAndEditContactScreenState();
}

class _AddAndEditContactScreenState extends State<AddAndEditContactScreen> {
  ContactController controller = Get.put(ContactController());

  final ContactModel? contactModel = Get.arguments;
  // List<Contact> _contacts = [];
  Contact? _selectedContact;

  String selectedImage = '';
  @override
  void initState() {
    // TODO: implement initState
    // _loadContacts();

    controller.contactNameController.text = contactModel?.fullName ?? "";
    controller.phoneNumberController.text = contactModel?.phoneNo ?? "";
    controller.emailAddressController.text = contactModel?.emailAddress ?? "";
    controller.companyNameController.text = contactModel?.company ?? "";
    controller.categoryNameController.text = contactModel?.profession ?? "";
    controller.addressController.text = contactModel?.address ?? "";super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(Duration(milliseconds: 300), () {
        init();
      });
    },);
  }

  // Future<void> _loadContacts() async {
  //   // await FlutterContacts.requestPermission();
  //   if (await Permission.contacts.request().isGranted) {
  //     // final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
  //     setState(() {
  //       _contacts = contacts;
  //       print(contacts.length);
  //     });
  //   }else {
  //     await FlutterContacts.requestPermission();
  //     final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
  //     setState(() {
  //       _contacts = contacts;
  //       print(contacts.length);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () =>
         ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: GetBuilder<ContactController>(
                builder: (controller) => SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon:
                                Icon(Icons.arrow_back, color: appColors.c1E4475),
                          ),
                          Text(
                            contactModel.isNull ? 'Add Contact' : 'Edit Contact',
                            textAlign: TextAlign.center,
                            style: appTextStyles.p308002E2E,
                          ),
                          SizedBox(width: 40.w),
                        ],
                      ),
                      4.h.verticalSpace,
                      AppAppBarShadowWidget(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildProfilePicture(controller),
                              _buildFormFields(controller),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 20.w),
                                child: AppBlueButton(
                                  title: 'Add',
                                  onTap: () async {
                                    if (controller.contactNameController.text.isEmpty) {
                                      myAlertDialog(
                                          message: 'Please Enter Your Contact Name',
                                          context: context);
                                      // Get.snackbar(
                                      //     'Name', 'please enter your contact name');
                                    } else if (controller
                                        .phoneNumberController.text.isEmpty) {
                                      myAlertDialog(
                                          message: 'Please Enter Phone Number',
                                          context: context);

                                      // Get.snackbar('Phone', 'Pleas enter phone number');
                                    }
                                    // else if (controller
                                    //     .emailAddressController.text.isEmpty) {
                                    //   myAlertDialog(
                                    //       message: 'Please Email Address',
                                    //       context: context);

                                      // Get.snackbar('Email', 'Pleas email address');
                                    // } else if (controller
                                    //     .companyNameController.text.isEmpty) {
                                    //   myAlertDialog(
                                    //       message: 'Please Enter Company Name',
                                    //       context: context);

                                      // Get.snackbar(
                                      //     'Company', 'Please enter company name');
                                    // }
                                    else if (controller
                                        .categoryNameController.text.isEmpty) {
                                      myAlertDialog(
                                          message: 'Select Your Contact Category',
                                          context: context);
                        
                                      // Get.snackbar(
                                      //     'Category', 'Select your contact category');
                                    }
                                    // else if (controller
                                    //     .addressController.text.isEmpty) {
                                    //   myAlertDialog(
                                    //       message: 'Please Enter Address',
                                    //       context: context);
                        
                                      // Get.snackbar('Address', 'Please enter address');
                                    // }
                                    else {
                                      // if (validateEmail(
                                      //     controller.emailAddressController.text)) {
                                        if (contactModel == null) {
                                          if (await controller.addContact(
                                              selectedImage.isEmpty
                                                  ? null
                                                  : selectedImage) ??
                                              false) {
                                            controller.getAllContacts();
                                            Get.back();
                                          } else {
                                            myAlertDialog(
                                                message: 'Please Select Contact Image',
                                                context: context);
                                            // Get.snackbar(
                                            //     'Alert', 'please select contact image');
                                          }
                                        } else {
                                          if (await controller.updateContact(
                                              contactModel?.id ?? 0,
                                              selectedImage.isNotEmpty
                                                  ? selectedImage
                                                  : null)) {
                                            // controller.getAllContacts();
                                            Get.back();
                                          }
                                          else {
                                            // Get.snackbar('Alert', 'Something went wrong');
                                            myAlertDialog(
                                                message: 'Something Went Wrong',
                                                context: context);
                                          }
                                        }
                                      // } else {
                                      //   myAlertDialog(
                                      //       message: 'Invalid Email', context: context);
                        
                                        // Get.snackbar('Alert', 'invalid email');
                                      // }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),
    ));
  }

  Widget _buildProfilePicture(ContactController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            width: 150.w,
            child: selectedImage.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      contactModel?.profile != null
                          ? CircleAvatar(
                              radius: 73,
                              backgroundColor: appColors.white,
                              backgroundImage: NetworkImage(contactModel
                                      ?.profile ??
                                  ""),
                            )
                          : selectedImage.isEmpty
                              ? SvgPicture.asset(
                                  appIcons.personIconSvg,
                                  color: appColors.cCBCDD7,
                                  width: 55.w,
                                  height: 55.h,
                                )
                              : Image.file(
                                  File(selectedImage),
                                  fit: BoxFit.contain,
                                ),
                    ],
                  )
                : null,
            height: 150.h,
            decoration: selectedImage.isNotEmpty
                ? BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(
                          File(
                            selectedImage,
                          ),
                        ),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    color: appColors.cF2F2F2,
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    color: appColors.cF2F2F2,
                  ),
          ),
          Positioned(
              right: 0,
              bottom: 3,
              child: GestureDetector(
                onTap: ()   {
                  // ======================================
                  showModalBottomSheet(
                    context: context,
                    builder: (cnt) {
                      return ImageSelectBottomSheetWidget(
                        onCameraTap: () async {
                          Navigator.pop(cnt);
                          var pickImage = await getImage(ImageSource.camera);
                          selectedImage = pickImage?.path ?? '';
                          controller.update();
                        },
                        onGalleryTap: () async {
                          Navigator.pop(cnt);
                          var pickImage = await getImage(ImageSource.gallery);
                          selectedImage = pickImage?.path ?? '';
                          controller.update();
                        },
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: appColors.primaryBlueColor,
                  ),
                  child: SvgPicture.asset(appIcons.addIconSvg,
                      color: appColors.white, height: 13.h, width: 13.w),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildFormFields(ContactController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            hintText: "Enter Name",
            textEditingController: controller.contactNameController,
            title: "Contact Name",
          ),
          AppTextField(
            hintText: "Enter Phone Number",
            textEditingController: controller.phoneNumberController,
            keyboardType: TextInputType.number,
            title: "Phone Number",
            inputFormatters: [
              LengthLimitingTextInputFormatter(12),
              FilteringTextInputFormatter.digitsOnly,
            ],
                        // suffixIcon: GestureDetector(onTap: ()async {
                        //   final nativeContact.FlutterContactPicker _contactPicker = nativeContact.FlutterContactPicker();
                        //   FocusManager.instance.primaryFocus?.unfocus();
                        //   nativeContact.Contact? contact = await _contactPicker.selectContact();
                        //
                        //   if (contact != null) {
                        //       controller.phoneNumberController.text = "${contact.phoneNumbers?[0]}";
                        //       controller.contactNameController.text = "${contact.fullName}";
                        //       _selectedContact?.displayName = contact.fullName??'';
                        //       _selectedContact?.phones[0].number = contact.phoneNumbers?[0]??'';
                        //   }
                        // },child: Icon(Icons.perm_contact_calendar_outlined),)
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width*0.9,
          //   margin: const EdgeInsets.symmetric(vertical: 4),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Visibility(
          //         child: Text(
          //           " Phone Number",
          //         ),
          //       ),
          //       const SizedBox(height: 10),
          //       DropdownButtonHideUnderline(
          //         child: SearchField<Contact>(
          //           controller: controller.phoneNumberController,
          //           suggestions: _contacts.map(
          //                 (e) => SearchFieldListItem<Contact>(
          //                   e.phones.length>0?
          //                   "${e.phones[0].number.toString()} (${e.name.first})":"(------)",
          //               item: e,
          //             ),
          //           ).toList(),
          //           itemHeight: 55,
          //           searchInputDecoration: InputDecoration(
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
          //                 color: appColors.c1E4475,
          //               ),
          //             ),
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(16.r),
          //               borderSide: BorderSide(
          //                 color: appColors.cDFDFDF,
          //               ),
          //             ),
          //             hintText: " Enter Phone Number",
          //             hintStyle: appTextStyles.p16400ADB,
          //             suffixIcon: GestureDetector(onTap: ()async {
          //               final nativeContact.FlutterContactPicker _contactPicker = nativeContact.FlutterContactPicker();
          //               FocusManager.instance.primaryFocus?.unfocus();
          //               nativeContact.Contact? contact = await _contactPicker.selectContact();
          //
          //               if (contact != null) {
          //                 // setState(() {
          //                   controller.phoneNumberController.text = "${contact.phoneNumbers?[0]}";
          //                   controller.contactNameController.text = "${contact.fullName}";
          //                   _selectedContact?.displayName = contact.fullName??'';
          //                   _selectedContact?.phones[0].number = contact.phoneNumbers?[0]??'';
          //                   // if(controller.contactNameController.text == ''){
          //                   //   controller.contactNameController.text ="${ _selectedContact?.name.first} ${ _selectedContact?.name.last}";
          //                   // }
          //                 // });
          //               }
          //             },child: Icon(Icons.perm_contact_calendar_outlined),)
          //           ),
          //           onSuggestionTap: (p0) {
          //             _selectedContact =  p0.item;
          //             print("_selectedContact==>> ${_selectedContact?.toJson()}");
          //             // print("_selectedContact==>> ${_selectedContact?.photo}");
          //             // print("_selectedContact==>> ${_selectedContact?.emails.length}");
          //             if(_selectedContact != null){
          //               controller.phoneNumberController.text = "${_selectedContact?.phones[0].number}";
          //               controller.contactNameController.text = "${_selectedContact?.name.first}";
          //               if(controller.contactNameController.text == ''){
          //                 controller.contactNameController.text ="${ _selectedContact?.name.first} ${ _selectedContact?.name.last}";
          //               }
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          AppTextField(
            hintText: "Enter Email",
            textEditingController: controller.emailAddressController,
            title: "Email Address",
          ),
          AppTextField(
            hintText: "Enter Company Name",
            textEditingController: controller.companyNameController,
            title: "Company Name",
          ),
          5.h.verticalSpace,
          AppDropDownWidget(
            options: controller.categoryList,
            selectedTitle: controller.categoryNameController.text.isEmpty
                ? null
                : controller.categoryNameController.text,
            title: 'Category',
            onChanged: (p0) {
              controller.categoryNameController.text = p0;
              controller.update();
            },
          ),
          5.h.verticalSpace,
          AppTextField(
            hintText: "Enter Address",
            textEditingController: controller.addressController,
            title: "Address",
          ),
        ],
      ),
    );
  }

  Future init() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding:
          EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: appColors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 30.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add a contact which is already in your phone",
                  textAlign: TextAlign.center,
                  style: appTextStyles.p167003131,
                ),
                15.h.verticalSpace,
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: AppBlueButton(
                            title: "Yes",onTap: () async{
                          final nativeContact.FlutterContactPicker _contactPicker = nativeContact.FlutterContactPicker();
                          FocusManager.instance.primaryFocus?.unfocus();
                          nativeContact.Contact? contact = await _contactPicker.selectContact();

                          if (contact != null) {
                            controller.phoneNumberController.text = "${contact.phoneNumbers?[0]}";
                            controller.contactNameController.text = "${contact.fullName}";
                            _selectedContact?.displayName = contact.fullName??'';
                            _selectedContact?.phones[0].number = contact.phoneNumbers?[0]??'';
                            Get.back();
                          }
                            },)),
                    15.w.horizontalSpace,
                    Flexible(
                        child: AppGreyButton(
                          title: "No",
                          onTap: () {
                            Get.back();
                          },
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
