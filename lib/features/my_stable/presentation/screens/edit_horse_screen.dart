import 'dart:io';
import 'dart:typed_data';

import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/drop_downs/app_dropdown.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/my_stable/controller/my_stable_controller.dart';
import 'package:equicare/features/my_stable/models/horse_details_model.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/functions/fun.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../common/widgets/image_select_bottom_sheet_widget.dart';
import '../../../../utils/constants/app_constants.dart';

class EditHorseScreen extends StatefulWidget {
  EditHorseScreen({super.key});

  @override
  State<EditHorseScreen> createState() => _EditHorseScreenState();
}

class _EditHorseScreenState extends State<EditHorseScreen> {
  final TextEditingController horseNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController disciplineController = TextEditingController();
  final TextEditingController sireController = TextEditingController();
  final TextEditingController damController = TextEditingController();
  final TextEditingController microchipNoController = TextEditingController();
  final TextEditingController eANumberController = TextEditingController();
  final TextEditingController aMFeedController = TextEditingController();
  final TextEditingController pMFeedController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController competitionNoController = TextEditingController();
  final TextEditingController horseNoteController = TextEditingController();
  String selectedImage = '';
  late MyStableController controller;
  List<XFile> multipleSelectedImage = [];
  List<HorseGallery> galleryImages = [];
  List<String> removeListImageIds = [];
  List<XFile> fileNames = [];

  @override
  void initState() {
    // TODO: implement initState
    int();
    super.initState();
  }

  void int() {
    controller = Get.put(MyStableController());
    horseNameController.text = controller.horseDetails?.name ?? "";
    dateOfBirthController.text =
        controller.horseDetails?.dateOfBirth?.convertDateFormatToDMYYYY() ?? "";
    heightController.text = controller.horseDetails?.height ?? "";
    sexController.text = controller.horseDetails?.sex ?? "";
    brandController.text = controller.horseDetails?.brand ?? "";
    breedController.text = controller.horseDetails?.breed ?? "";
    colorController.text = controller.horseDetails?.colour ?? "";
    disciplineController.text = controller.horseDetails?.descipline ?? "";
    sireController.text = controller.horseDetails?.sire ?? "";
    damController.text = controller.horseDetails?.dam ?? "";
    microchipNoController.text = controller.horseDetails?.microchipNumber ?? "";
    eANumberController.text = controller.horseDetails?.eaNumber ?? "";
    aMFeedController.text = controller.horseDetails?.amFeed?? "";
    pMFeedController.text = controller.horseDetails?.pmFeed ?? "";
    weightController.text = controller.horseDetails?.weight ?? "";
    competitionNoController.text = controller.horseDetails?.colour ?? "";
    horseNoteController.text = controller.horseDetails?.colour ?? "";
    horseNoteController.text = controller.horseDetails?.notes ?? "";
    // galleryImages.addAll(controller.horseDetails!.gallery!.map((e) {
    //   if(e.image.contains('.pdf')){
    //
    //   }
    // },)
    //     .toList());
    if(controller.horseDetails?.gallery != null){
      List<HorseGallery> gIList = [];
      var gI = controller.horseDetails?.gallery??[];
      gI.forEach((element) {
        // if(!element.image!.contains('.pdf')){
          galleryImages.add(element);
        // }
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>

            // controller.isLoading.value
            //     ? Center(child: CircularProgressIndicator())
            //     :

            ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: GetBuilder<MyStableController>(
            builder: (controller) => SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: appColors.c1E4475,
                            )),
                        Text(
                          'Edit Horse',
                          textAlign: TextAlign.center,
                          style: appTextStyles.p308002E2E,
                        ),
                        SizedBox(
                          width: 40,
                        )
                      ],
                    ),
                    4.h.verticalSpace,
                    const AppAppBarShadowWidget(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
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
                                // width: 140.w,
                                child: selectedImage.isEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          controller.horseDetails
                                                      ?.profileImage !=
                                                  null
                                              ? CircleAvatar(
                                                  maxRadius: 73,
                                                  backgroundColor:
                                                      appColors.white,
                                                  backgroundImage: NetworkImage(
                                                      controller.horseDetails
                                                              ?.profileImage ??
                                                          "http://52.64.88.49/equicare-dev/storage/app/public/images/93a7a9256cc9bc73105b07fb14558d79.png"),
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
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      // var pickImage = await getImage(
                                      //     ImageSource.gallery);
                                      // selectedImage =
                                      //     pickImage?.path ?? '';
                                      // controller.update();

                                      // =====================================

                                      showModalBottomSheet(
                                        context: context,
                                        builder: (cnt) {
                                          return ImageSelectBottomSheetWidget(
                                            onCameraTap: () async {
                                              Navigator.pop(cnt);
                                              var pickImage = await getImage(
                                                  ImageSource.camera);
                                              selectedImage =
                                                  pickImage?.path ?? '';
                                              controller.update();
                                            },
                                            onGalleryTap: () async {
                                              Navigator.pop(cnt);
                                              var pickImage = await getImage(
                                                  ImageSource.gallery);
                                              selectedImage =
                                                  pickImage?.path ?? '';
                                              controller.update();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: appColors.primaryBlueColor,
                                      ),
                                      child: SvgPicture.asset(
                                          appIcons.addIconSvg,
                                          color: appColors.white,
                                          height: 13.h,
                                          width: 13.w),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            hintText: "Enter Name",
                            textEditingController: horseNameController,
                            title: "Horse Name",
                          ),
                          AppDropDownWidget(
                              selectedTitle: sexController.text.isEmpty
                                  ? null
                                  : sexController.text,
                              // selectedTitle: sexController.text,
                              options: const <String>[
                                "Filly",
                                "Colt",
                                "Mare",
                                "Gelding",
                                "Stallion"
                              ],
                              onChanged: (p0) {
                                sexController.text = p0 ?? "";
                                controller.update();
                              },
                              title: 'Sex'),
                          AppTextField(
                            hintText: "Enter Breed",
                            textEditingController: breedController,
                            title: "Breed",
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     FocusManager.instance.primaryFocus?.unfocus();
                          //     var time = await showTimePicker(
                          //       context: context,
                          //       initialTime: TimeOfDay.now(),
                          //     );
                          //     if (time != null) {
                          //       aMFeedController.text =
                          //           "${time.hour}:${time.minute}"
                          //               .convertToAmPm();
                          //     }
                          //   },
                          //   child: AppTextField(
                          //     hintText: "Enter Feed",
                          //     textEditingController: aMFeedController,
                          //     title: "AM Feed",
                          //     isEnabled: false,
                          //     suffixIcon: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         SvgPicture.asset(
                          //           appIcons.watchIconSvg,
                          //           color: appColors.c1E4475,
                          //           width: 20.w,
                          //           height: 20.h,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          AppTextField(
                            hintText: "Enter Feed",
                            textEditingController: aMFeedController,
                            title: "AM Feed",
                            maxLines: 3,
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     FocusManager.instance.primaryFocus?.unfocus();
                          //     var cTime = DateTime.utc(1, 1, 1, 18);
                          //     var time = await showTimePicker(
                          //       context: context,
                          //       initialTime: TimeOfDay.fromDateTime(cTime),
                          //     );
                          //     if (time != null) {
                          //       pMFeedController.text =
                          //           "${time.hour}:${time.minute}"
                          //               .convertToAmPm();
                          //     }
                          //   },
                          //   child: AppTextField(
                          //     hintText: "Enter Feed",
                          //     textEditingController: pMFeedController,
                          //     title: "PM Feed",
                          //     isEnabled: false,
                          //     suffixIcon: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         SvgPicture.asset(
                          //           appIcons.watchIconSvg,
                          //           color: appColors.c1E4475,
                          //           width: 20.w,
                          //           height: 20.h,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          AppTextField(
                            hintText: "Enter Feed",
                            textEditingController: pMFeedController,
                            title: "PM Feed",
                            maxLines: 3,
                          ),
                          InkWell(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              var date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.utc(1960),
                                  lastDate: DateTime.now());

                              if (date != null) {
                                dateOfBirthController.text =
                                    "${date.day}/${date.month}/${date.year}";
                              }
                            },
                            child: AppTextField(
                              hintText: "DD/MM/YYYY",
                              textEditingController: dateOfBirthController,
                              title: "Date of Birth",
                              isEnabled: false,
                              suffixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    appIcons.calendarIconSvg,
                                    color: appColors.c1E4475,
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AppTextField(
                              hintText: "Enter Height",
                              textEditingController: heightController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                              title: "Height (In HH)",
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                                // FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                              ]),
                          AppTextField(
                            hintText: "Enter Brand",
                            textEditingController: brandController,
                            title: "Brand",
                          ),
                          AppTextField(
                            hintText: "Enter Colour",
                            textEditingController: colorController,
                            title: "Colour",
                          ),
                          AppTextField(
                            hintText: "Enter Discipline",
                            textEditingController: disciplineController,
                            title: "Discipline",
                          ),
                          AppTextField(
                            hintText: "Enter Weight",
                            textEditingController: weightController,
                            title: "Weight (IN KG)",
                            keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              // FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                            ],
                          ),
                          AppTextField(
                            hintText: "Enter Sire",
                            textEditingController: sireController,
                            title: "Sire",
                          ),
                          AppTextField(
                            hintText: "Enter Dam",
                            textEditingController: damController,
                            title: "Dam",
                          ),
                          AppTextField(
                            hintText: "Enter Microchip Number",
                            textEditingController: microchipNoController,
                            title: "Microchip Number",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          AppTextField(
                            hintText: "Enter EA Number",
                            textEditingController: eANumberController,
                            title: "EA(Competition) Number",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          
                          // AppTextField(
                          //   hintText: "Enter Competition No.",
                          //   textEditingController: competitionNoController,
                          //   title: "Competition No.",
                          // ),
                          AppTextField(
                            hintText: "Write a note here...",
                            textEditingController: horseNoteController,
                            title: "Notes",
                            maxLines: 3,
                          ),
                          10.h.verticalSpace,
                          Padding(
                            padding: EdgeInsets.only(left: 7.w),
                            child: Text('Add Horse Images'),
                          ),
                          8.h.verticalSpace,
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: multipleSelectedImage.length +
                                    galleryImages.length +
                                    fileNames.length+
                                    1,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? GestureDetector(
                                          onTap: () async {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (cnt) {
                                                return ImageAndPdfSelectBottomSheetWidget(
                                                  onPdfTap: () async {
                                                    Get.back();
                                                    try {
                                                      final result = await FilePicker
                                                          .platform
                                                          .pickFiles(
                                                        // allowedExtensions: ['pdf'],
                                                          allowMultiple:
                                                          true);

                                                      if (result !=
                                                          null &&
                                                          result.files
                                                              .isNotEmpty) {
                                                        print(
                                                            'Number of files picked: ${result.files.length}');

                                                        for (var file in result.files) {
                                                          XFile? xFile = file.xFile;
                                                          print('Adding file path: $xFile');

                                                          if (xFile != null) {
                                                            if (xFile.path.contains('.pdf')) {
                                                              if (xFile.path.isNotEmpty) {
                                                                fileNames.add(xFile);
                                                              }
                                                            } else {
                                                              myAlertDialog(message: 'Select Only PDF', context: context);
                                                              break; // Use `break` to exit the loop as `return` does in the original code
                                                            }
                                                          }
                                                        }
                                                      } else {
                                                        print(
                                                            'No files selected');
                                                      }
                                                    } catch (e) {
                                                      print(
                                                          'Error: $e');
                                                    }
                                                    controller.update();
                                                  },
                                                  onGalleryTap:
                                                      () async {
                                                        Get.back();
                                                        var images = await getImages();
                                                        multipleSelectedImage.addAll(images
                                                            .map(
                                                              (e) => e,
                                                        )
                                                            .toList());
                                                        controller.update();
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            width: 95.w,
                                            height: 88.h,
                                            decoration: BoxDecoration(
                                                color: appColors.cE6E6E6,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.r)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  appIcons.addIconSvg,
                                                  color: appColors.c818393,
                                                  width: 23.w,
                                                  height: 23.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            multipleSelectedImage.length > index - 1?
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: CircleAvatar(
                                                maxRadius: 48,
                                                backgroundImage: FileImage(File(multipleSelectedImage[index - 1].path))
                                              ),
                                            ):
                                            fileNames.length>index-1-multipleSelectedImage.length?
                                            Container(
                                              margin:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  5),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black12,
                                                maxRadius: 48,
                                                child: Icon(Icons
                                                    .picture_as_pdf_outlined,size: 45,),
                                              ),
                                            ):
                                            (galleryImages[index - 1 - multipleSelectedImage.length-fileNames.length].image ??"").contains('.pdf')?
                                            Container(
                                              margin:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  5),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black12,
                                                maxRadius: 48,
                                                child: Icon(Icons
                                                    .picture_as_pdf_outlined,size: 45,),
                                              ),
                                            ):
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black12,
                                                maxRadius: 48,
                                                backgroundImage: NetworkImage(galleryImages[index - 1 - multipleSelectedImage.length-fileNames.length].image ??"")
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (multipleSelectedImage.length > index - 1) {
                                                  multipleSelectedImage.removeAt(index - 1);
                                                  print('SelectedImage ???????????????');
                                                }else if (fileNames.length >index - 1-multipleSelectedImage.length) {
                                                  fileNames.removeAt(index - 1-multipleSelectedImage.length);
                                                  print('file ???????????????');
                                                } else {
                                                  removeListImageIds.add("${galleryImages[index - multipleSelectedImage.length - 1-fileNames.length].id}");
                                                  galleryImages.removeAt(index -multipleSelectedImage.length -1-fileNames.length);
                                                  print('galleryImages ???????????????');
                                                }
                                                controller.update();
                                              },
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 4.0),
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                }),
                          ),
                          20.h.verticalSpace,
                          AppBlueButton(
                            title: 'Save Changes',
                            onTap: () async {
                              if (horseNameController.text.isEmpty) {
                                myAlertDialog(
                                    message: "Please Enter Horse Name",
                                    context: context);
                                // Get.snackbar(
                                //     'Name', "Please enter horse name");
                              }
                              // else if (dateOfBirthController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Date Of Birth",
                              //       context: context);
                              //   // Get.snackbar(
                              //   //     'DOB', "Please enter date of birth");
                              // } else if (heightController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Horse Height",
                              //       context: context);
                              //   // Get.snackbar(
                              //   //     'Height', "Please enter horse height");
                              // } else if (brandController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Brand",
                              //       context: context);
                              //   // Get.snackbar('Brand', "Please enter brand");
                              // } else if (breedController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Breed",
                              //       context: context);
                              //   // Get.snackbar('Breed', "Please enter breed");
                              // } else if (colorController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Color",
                              //       context: context);
                              //   // Get.snackbar('Color', "Please enter color");
                              // } else if (disciplineController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Discipline",
                              //       context: context);
                              //   // Get.snackbar('Discipline',
                              //   //     "Please enter discipline");
                              // } else if (sireController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Sire",
                              //       context: context);
                              //   // Get.snackbar('Sire', "Please enter sire");
                              // } else if (damController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Dam",
                              //       context: context);
                              //   // Get.snackbar('Dam', "Please enter dam");
                              // } else if (microchipNoController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Microchip Number",
                              //       context: context);
                              //   // Get.snackbar('Microchip Number',
                              //   //     "Please enter microchip number");
                              // } else if (eANumberController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter EA Number",
                              //       context: context);
                              //   // Get.snackbar(
                              //   //     'EA Number', "Please enter EA number");
                              // } else if (aMFeedController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter AM Feed",
                              //       context: context);
                              //   // Get.snackbar(
                              //   //     'AM feed', "Please enter AM feed");
                              // } else if (pMFeedController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter PM Feed",
                              //       context: context);
                              //   // Get.snackbar(
                              //   //     'PM feed', "Please enter PM feed");
                              // } else if (weightController.text.isEmpty) {
                              //   myAlertDialog(
                              //       message: "Please Enter Weight",
                              //       context: context);
                              //   // Get.snackbar(
                              //   //     'Weight', "Please enter weight");
                              // }
                              else {
                                try {
                                  List<Uint8List> galleryU8 = [];
                                  for (var file in multipleSelectedImage) {
                                    var u8 = await file.readAsBytes();
                                    galleryU8.add(u8);
                                  }
                                  List<Uint8List> galleryPdfU8 = [];
                                  for (var file in fileNames) {
                                    var u8 = await file.readAsBytes();
                                    galleryPdfU8.add(u8);
                                  }
                                  var res = await controller.addAndEditHorse(
                                      horseName:
                                          horseNameController.text.trim(),
                                      dateOfBirth: dateOfBirthController.text
                                          .convertDateFormatToYYYYMMDD(),
                                      height: heightController.text.trim(),
                                      sex: sexController.text.trim(),
                                      brand: brandController.text.trim(),
                                      breed: breedController.text.trim(),
                                      color: colorController.text.trim(),
                                      discipline:
                                          disciplineController.text.trim(),
                                      sire: sireController.text.trim(),
                                      dam: damController.text.trim(),
                                      microchipNo:
                                          microchipNoController.text.trim(),
                                      eANumber: eANumberController.text.trim(),
                                      aMFeed: aMFeedController.text.trim(),
                                      pMFeed: pMFeedController.text.trim(),
                                      weight: weightController.text.trim(),
                                      competitionNo:
                                          competitionNoController.text.trim(),
                                      galleryImage: galleryU8,
                                      profileImage: selectedImage,
                                      id: controller.horseDetails?.id,
                                      selectedImage: selectedImage.isNotEmpty
                                          ? selectedImage
                                          : null,
                                      removeImagesIds:
                                          removeListImageIds.isEmpty
                                              ? null
                                              : removeListImageIds, galleryPdfU8: fileNames.isNotEmpty
                                      ? galleryPdfU8
                                      : [], note:horseNoteController.text.trim());
                                  if (res == true) {
                                    Get.back();
                                    // Get.snackbar("Message",
                                    //     "Horse updated Successfully");
                                  }
                                } catch (e) {
                                  myAlertDialog(
                                      message: "$e", context: context);

                                  // Get.snackbar("Error", "$e");
                                }
                              }
                            },
                          ),
                          20.h.verticalSpace,
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    horseNameController.dispose();
    dateOfBirthController.dispose();
    heightController.dispose();
    sexController.dispose();
    brandController.dispose();
    breedController.dispose();
    colorController.dispose();
    disciplineController.dispose();
    sireController.dispose();
    damController.dispose();
    microchipNoController.dispose();
    eANumberController.dispose();
    aMFeedController.dispose();
    pMFeedController.dispose();
    weightController.dispose();
    competitionNoController.dispose();
    super.dispose();
  }
}
