import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/drop_downs/app_dropdown.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/contacts/model/contact_model.dart';
import 'package:equicare/features/my_calendar/controller/calendar_controller.dart';
import 'package:equicare/features/my_calendar/models/event_data_model.dart';
import 'package:equicare/features/my_calendar/models/new/edit_event_modal.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/functions/fun.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../common/widgets/image_select_bottom_sheet_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../my_stable/models/horse_details_model.dart';
import '../../../my_stable/models/my_stable_model.dart';
import '../../models/event_types_with_category_model/event_type_category_model.dart';
import '../../models/get_questions_model/get_health_questions_model.dart';
import '../../models/new/event_fields_model.dart';
import 'add_event_screen.dart';

class EditEventScreen extends StatefulWidget {
  EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  int? firstTabSelectedIndex;
  bool switchButton = false;
  late CalendarController calendarController;
  String? selectedHorseName;
  String? selectedContactName;
  String? selectedEvent;
  // final TextEditingController firstBaTextEditingController =
  //     TextEditingController();
  // final TextEditingController secondBaTextEditingController =
  //     TextEditingController();

  // String? bADropDownTitle;
  // String? bBDropDownTitle;
  // final TextEditingController firstBbTextEditingController =
  //     TextEditingController();
  // final TextEditingController secondBbTextEditingController =
  //     TextEditingController();
  // final TextEditingController firstBcTextEditingController =
  //     TextEditingController();
  // final TextEditingController secondBcTextEditingController =
  //     TextEditingController();
  // String? bCDropDownTitle;

  // final TextEditingController firstBdTextEditingController =
  //     TextEditingController();
  // final TextEditingController secondBdTextEditingController =
  //     TextEditingController();
  DateTime? startDate = DateTime.now();
  TimeOfDay? startTime;
  List<XFile> multipleSelectedImage = [];
  List<EventImage> galleryImages = [];
  List<String> removeListImageIds = [];
  List<XFile> fileNames = [];

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController horseController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? eventTypeId;
  String? horseId;
  String? contactId;
  String? repeat;
  String? endRepeat;
  String? alert;
  String? eventId;
  String? date;
  // var data;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future<void> init() async {
    calendarController = Get.find(tag: "calendarController");
    date = Get.arguments["date"];
    String originalDateStr = "2024-8-30";

    // Create a DateFormat instance for parsing the date
    DateFormat originalFormat = DateFormat("yyyy-M-d");

    // Parse the original date string to a DateTime object
    DateTime dateTime = originalFormat.parse(originalDateStr);

    // Create a DateFormat instance for formatting the date
    DateFormat targetFormat = DateFormat("yyyy-MM-dd");

    // Format the DateTime object to the desired format
    String formattedDateStr = targetFormat.format(dateTime);
    date = formattedDateStr;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await calendarController.getEventType();
         await calendarController.getEventForEdit(eventId:  Get.arguments["eventId"].toString());
        if(calendarController.data is EditEventModel){
          firstTabSelectedIndex=(calendarController.data.eventTypeId??1)-1;
          locationController.text=calendarController.data.location??"";
          if(calendarController.data.startDate!=null){
            startDateController.text=DateFormat("dd/MM/yyyy").format(calendarController.data.startDate!);
          }
          if(calendarController.data.endDate!=null){
            endDateController.text=DateFormat("dd/MM/yyyy").format(calendarController.data.endDate!);
          }
          switchButton = calendarController.data.startTime== "00:00:00"?true:false;
          startTimeController.text=switchButton?"":calendarController.data.startTime!.convertToAmPm()??"";
          endTimeController.text=switchButton?"":calendarController.data.endTime!.convertToAmPm()??"";
          String? key =  calendarController.frequencyMap.keys.firstWhere(
                  (k) =>  calendarController.frequencyMap[k] == calendarController.data.eventRepeat, orElse: () => "Never");
          repeat=key;
          var sContact = calendarController.contactList.where((value)=>value.id==int.parse(calendarController.data.contact??"1"));
          selectedContactName = sContact.first.fullName??"";
          alert = calendarController.data.alert;
          var horseName = calendarController.myStableList.where((value)=>value.id == calendarController.data.horseId);
          horseController.text = horseName.first.name??'';
          noteController.text = calendarController.data.notes??'';
          galleryImages = calendarController.data.eventImages??[];
          List<EventFieldsModel> fields = calendarController.data.fieldsResponse??[];
          int textfield = 0;
          for(int i=0;i<fields.length;i++){
            if(fields[i].type == 'select'&&i==0){
              calendarController.listOfEventTypes.add(fields[i].copyWith(eventTypeId: calendarController.data.eventTypeId));
              calendarController.selectedEventHealth = fields[i].value;
            }else if(fields[i].type == 'select'&&i==1){
              calendarController.childFields1.add(fields[i].copyWith(eventTypeId: calendarController.data.eventTypeId));
              calendarController.selectedChildValue1 = fields[i].value;
            }else if(fields[i].type == 'select'&&i==2){
              calendarController.childFields2.add(fields[i].copyWith(eventTypeId: calendarController.data.eventTypeId));
              calendarController.selectedChildValue2 = fields[i].value;
            }else if(fields[i].type == 'radio'){
              calendarController.radioButtonList.add(fields[i].copyWith(eventTypeId: calendarController.data.eventTypeId));
              calendarController.selectedRadioOption = fields[i].value;
            }else if(fields[i].type == 'textbox'){
              calendarController.listOfTextFormField.add(fields[i].copyWith(eventTypeId: calendarController.data.eventTypeId));
              // for(textfield=0;textfield<4;textfield++) {
                calendarController.listOfTextEditingController[textfield].text =
                    fields[i].value ?? '';
                textfield++;
              // }
            }

          }
          endRepeat = calendarController.data.endDate!= null ?"On Date":repeat!='Never'?'Never':null;
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    calendarController.clearData();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
            init: calendarController,
            builder: (controller) {
              return

                  // controller.isLoading.value
                  //     ? Center(
                  //         child: CircularProgressIndicator(
                  //           color: appColors.primaryBlueColor,
                  //         ),
                  //       )
                  //     :

                  ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Edit Event',
                            textAlign: TextAlign.center,
                            style: appTextStyles.p308002E2E,
                          ),
                          SizedBox(
                            width: 40,
                          )
                        ],
                      ),
                      10.h.verticalSpace,
                      const AppAppBarShadowWidget(),
                      4.h.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Text(
                          'Event Type',
                          style: appTextStyles.p14400313131,
                        ),
                      ),
                      8.h.verticalSpace,
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 48,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.eventTypeWithCategoryList.length,
                            itemBuilder: (context, index) {
                              var eventType =
                                  controller.eventTypeWithCategoryList[index];
                              return GestureDetector(
                                onTap: () {
                                  firstTabSelectedIndex = index;
                                  controller.selectedEventHealth = null;
                                  controller.getEventFields(
                                      eventTypeId: "${index + 1}",
                                      isFromTab: true);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 13),
                                  decoration: firstTabSelectedIndex == index
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: appColors.c1E4475)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: appColors.cAEB0C3
                                              .withOpacity(0.1)),
                                  child: Center(
                                      child: Text(
                                    "${eventType.name}",
                                    // firstTabItems[index],
                                    style: firstTabSelectedIndex == index
                                        ? appTextStyles.p16500White
                                        : appTextStyles.p16500White
                                            .copyWith(color: appColors.cAEB0C3),
                                  )),
                                ),
                              );
                            },
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            14.h.verticalSpace,
                            // AppDropDownWidget(
                            //   options: const [],
                            //   items: [],
                            //   // controller.myStableList
                            //   //     .map(
                            //   //       (e) => DropdownMenuItem(
                            //   //         value: e,
                            //   //         child: Text("${e.name}"),
                            //   //       ),
                            //   //     )
                            //   //     .toList(),
                            //   title: 'Horse',
                            //   selectedTitle: selectedHorseName,
                            //   onChanged: (p0) {
                            //     if (p0 is MyStableModel) {
                            //       horseId = p0.id.toString();
                            //       selectedHorseName = p0.name;
                            //       controller.update();
                            //     }
                            //   },
                            // ),
                            AppTextField(
                              title: 'Horse',
                              isEnabled: false,

                              textEditingController: horseController,
                              // selectedTitle: selectedHorseName,
                              onChanged: (p0) {
                                // if (p0 is MyStableModel) {
                                //   horseId = p0.id.toString();
                                //   selectedHorseName = p0.name;
                                //   controller.update();
                                // }
                              }, hintText: 'Your Horse',
                            ),
                            14.h.verticalSpace,
                            AppDropDownWidget(
                              options: const [],
                              selectedTitle: selectedContactName,
                              items: controller.contactList
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text("${e.fullName}"),
                                    ),
                                  )
                                  .toList(),
                              title: 'Contact',
                              onChanged: (p0) {
                                if (p0 is ContactModel) {
                                  selectedContactName = p0.fullName;
                                  contactId = p0.id.toString();
                                  controller.update();
                                }
                              },
                            ),
                            6.h.verticalSpace,
                            // Padding(
                            //   padding: EdgeInsets.only(left: 3.w),
                            //   child: Text(
                            //     'Location',
                            //     style: appTextStyles.p14400313131,
                            //   ),
                            // ),
                            // 10.h.verticalSpace,
                            // Container(
                            //   padding: EdgeInsets.symmetric(vertical: 15.h),
                            //   alignment: Alignment.center,
                            //   width: double.maxFinite,
                            //   decoration: BoxDecoration(
                            //     color: appColors.cAEB0C3.withOpacity(0.1),
                            //     borderRadius: BorderRadius.circular(16.r),
                            //   ),
                            //   child: Text(
                            //     'Select Location',
                            //     style: appTextStyles.p164001EBlue,
                            //   ),
                            // ),
                            AppTextField(
                                hintText: 'Location',
                                textEditingController: locationController,
                                title: "Enter location"),
                            6.h.verticalSpace,

                            //===========================================

                            Column(
                              children: [
                                // Parent Dropdown
                                Column(
                                  children: List.generate(
                                      controller.listOfEventTypes
                                          .length, (index) {
                                    return Visibility(
                                      visible: controller
                                          .listOfEventTypes[index]
                                          .type ==
                                          'select',
                                      child: AppDropDownWidget(
                                        selectedTitle: controller
                                            .selectedEventHealth, // Use a default prompt
                                        key: UniqueKey(),
                                        options: const [],
                                        items: controller
                                            .listOfEventTypes[index]
                                            .values
                                            ?.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        title: controller
                                            .listOfEventTypes[index]
                                            .label ??
                                            'Event',
                                        onChanged: (p0) async {
                                          // Add selected value to the list
                                          if (controller
                                              .selectedEventHealth !=
                                              p0) {
                                            controller
                                                .selectedEventHealth = p0;
                                            await controller
                                                .getEventFieldsChild1(
                                              eventTypeId: controller
                                                  .listOfEventTypes[
                                              index]
                                                  .eventTypeId
                                                  .toString(),
                                              fieldValue: p0,
                                              fieldId: controller
                                                  .listOfEventTypes[
                                              index]
                                                  .id
                                                  .toString(),
                                            );
                                            calendarController.clearlisttext();
                                            controller.update();
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ),
                                // Child 1 Dropdowns
                                Column(
                                  children: List.generate(
                                      controller.childFields1.length,
                                          (index) {
                                        var field =
                                        controller.childFields1[index];
                                        return Visibility(
                                          visible: field.type == 'select',
                                          child: AppDropDownWidget(
                                            selectedTitle: controller
                                                .selectedChildValue1, // Reset or use another variable to store selected child values
                                            key: UniqueKey(),
                                            options: const [],
                                            items: field.values?.map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              );
                                            }).toList(),
                                            title: field.label ??
                                                'Child Event',
                                            onChanged: (p0) async {
                                              // Add selected child value to the list
                                              controller.selectedValues
                                                  .add(p0);
                                              controller
                                                  .selectedChildValue1 = p0;
                                              await controller
                                                  .getEventFieldsChild2(
                                                eventTypeId: controller
                                                    .childFields1[index]
                                                    .eventTypeId
                                                    .toString(),
                                                fieldValue: p0,
                                                fieldId: controller
                                                    .childFields1[index].id
                                                    .toString(),
                                              );
                                              calendarController.clearlisttext();
                                              if(controller.selectedChildValue1 != 'Full'){
                                                controller.radioButtonList.clear();
                                                controller.selectedRadioOption = null;
                                              }
                                            },
                                          ),
                                        );
                                      }),
                                ),
                                // Child 2 Dropdowns
                                Column(
                                  children: List.generate(
                                      controller.childFields2.length,
                                          (index) {
                                        var field =
                                        controller.childFields2[index];
                                        return Visibility(
                                          visible: field.type == 'select',
                                          child: AppDropDownWidget(
                                            selectedTitle: controller
                                                .selectedChildValue2, // Reset or use another variable to store selected child values
                                            key: UniqueKey(),
                                            options: const [],
                                            items: field.values?.map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              );
                                            }).toList(),
                                            title: field.label ??
                                                'Child Event',
                                            onChanged: (p0) async {
                                              controller
                                                  .selectedChildValue2 = p0;
                                              // Add selected child value to the list
                                              controller.selectedValues
                                                  .add(p0);
                                              await controller
                                                  .getEventFieldsChild2(
                                                eventTypeId: controller
                                                    .childFields2[index]
                                                    .eventTypeId
                                                    .toString(),
                                                fieldValue: p0,
                                                fieldId: controller
                                                    .childFields2[index].id
                                                    .toString(),
                                              );
                                              calendarController.clearlisttext();
                                              controller.update();
                                            },
                                          ),
                                        );
                                      }),
                                ),
                                // Radio btn
                                Column(
                                  children: controller.radioButtonList
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    var radioButtonItem = entry.value;

                                    // Check if the type is 'radio' before displaying the custom widget
                                    return radioButtonItem.type == 'radio'
                                        ? RadioButtonGroup(controller: controller,
                                      eventId:  controller
                                          .radioButtonList[index]
                                          .eventTypeId
                                          .toString(),
                                      fieldId: controller
                                          .radioButtonList[index].id
                                          .toString(),
                                    )
                                        : SizedBox(); // Empty space when the type is not 'radio'
                                  })
                                      .toList(),
                                ),
                                // text fields
                                Column(
                                  children: List.generate(
                                      controller.listOfTextFormField
                                          .length, (index) {
                                    return Visibility(
                                      visible: controller
                                          .listOfTextFormField[
                                      index]
                                          .type ==
                                          'textbox',
                                      child: AppTextField(
                                        hintText: controller
                                            .listOfTextFormField[
                                        index]
                                            .label ??
                                            '',
                                        title: '',
                                        textEditingController:
                                        controller.listOfTextEditingController[index],
                                        onChanged: (value) {
                                          // Optionally, handle changes to the text field
                                          // For example, you could add this value to the selected values list
                                          controller.selectedValues.add(
                                              value); // Assuming selectedValues is defined in your controller
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),

                            //===========================================

                            AppDropDownWidget(
                              options: const [
                                "Never",
                                "Daily",
                                "Twice a Day (8am &, 5pm)",
                                "Three Times a Day (8am, 1pm & 5pm)",
                                "Every Second Day",
                                "Weekly",
                                "Every 2 weeks",
                                "Every 3 weeks",
                                "Every 4 weeks",
                                "Every 5 weeks",
                                "Every 6 weeks",
                                "Monthly",
                                "Every 2 Months",
                                "Every 3 Months",
                                "Every 4 Months",
                                "Every 5 Months",
                                "Every 6 Months",
                                "Once a Year"
                              ],
                              title: 'Repeat',
                              selectedTitle: repeat,
                              onChanged: (p0) {
                                repeat = p0;
                                if(repeat == "Never"){
                                  endRepeat=null;
                                }
                                controller.update();
                              },
                            ),
                            4.h.verticalSpace,
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding:
                              EdgeInsets.all(10).copyWith(top: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: appColors.white),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 6.0.h,
                                        left: 2.w,
                                        right: 2.w),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'All-Day',
                                          style:
                                          appTextStyles.p14400313131,
                                        ),
                                        Switch(
                                          value: switchButton,
                                          onChanged: (value) {
                                            switchButton = !switchButton;
                                            setState(() {});
                                          },
                                          activeColor: appColors.c1E4475,
                                          activeTrackColor: appColors
                                              .c818393
                                              .withOpacity(0.15),
                                          inactiveThumbColor:
                                          appColors.cAEB0C3,
                                          inactiveTrackColor: appColors
                                              .c818393
                                              .withOpacity(0.15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 6.0.h,
                                        left: 2.w,
                                        right: 2.w),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Starts',
                                          style:
                                          appTextStyles.p14400313131,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                var date =
                                                await showDatePicker(
                                                  // barrierColor: Colors.red,
                                                    context: context,
                                                    firstDate:
                                                    DateTime
                                                        .now(),
                                                    lastDate:
                                                    DateTime.utc(
                                                        2099));
                                                if (date != null) {
                                                  startDateController
                                                      .text =
                                                      "${date.day}/${date.month}/${date.year}"
                                                          .convertDateFormatToDMYYYY();
                                                  startDate = date;
                                                  endDateController.text =
                                                  "${date.day}/${date.month}/${date.year}";
                                                }
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5),
                                                    color: appColors
                                                        .cAEB0C3
                                                        .withOpacity(
                                                        0.17)),
                                                child: Text(
                                                  startDateController
                                                      .text.isEmpty
                                                      ? DateTime.now()
                                                      .convertToYYYYMMDD()
                                                      : startDateController
                                                      .text,
                                                  style: appTextStyles
                                                      .p167003131
                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                              ),
                                            ),
                                            5.horizontalSpace,
                                            if (!(repeat ==
                                                'Three Times a Day (8am, 1pm & 5pm)' ||
                                                repeat ==
                                                    'Twice a Day (8am &, 5pm)'))
                                              Visibility(
                                                visible: !switchButton,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    FocusManager.instance
                                                        .primaryFocus
                                                        ?.unfocus();
                                                    var time =
                                                    await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                      TimeOfDay.now(),
                                                    );
                                                    if (time != null) {
                                                      startTimeController
                                                          .text =
                                                          "${time.hour}:${time.minute}"
                                                              .convertToAmPm();
                                                      startTime = time;
                                                      endTimeController
                                                          .text =
                                                          "${time.hour}:${time.minute}"
                                                              .convertToAmPm();
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5),
                                                        color: appColors
                                                            .cAEB0C3
                                                            .withOpacity(
                                                            0.17)),
                                                    child: Text(
                                                        startTimeController
                                                            .text
                                                            .isEmpty
                                                            ? DateTime
                                                            .now()
                                                            .convertToYYYYMMDDWithTime()
                                                            : startTimeController
                                                            .text,
                                                        style: appTextStyles
                                                            .p167003131
                                                            .copyWith(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500)),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  if (!(repeat == "Never"))
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 6.0.h,
                                          left: 2.w,
                                          right: 2.w),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            'Ends',
                                            style: appTextStyles
                                                .p14400313131,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  FocusManager.instance
                                                      .primaryFocus
                                                      ?.unfocus();
                                                  if (startDate != null) {
                                                    var date =
                                                    await showDatePicker(
                                                      // barrierColor: Colors.red,
                                                        context:
                                                        context,
                                                        firstDate: DateTime.utc(
                                                            startDate!
                                                                .year,
                                                            startDate!
                                                                .month,
                                                            startDate!
                                                                .day),
                                                        lastDate: DateTime.utc(
                                                            startDate!
                                                                .year +
                                                                1,
                                                            startDate!
                                                                .month,
                                                            startDate!
                                                                .day));
                                                    if (date != null) {
                                                      endDateController
                                                          .text =
                                                          "${date.day}/${date.month}/${date.year}"
                                                              .convertDateFormatToDMYYYY();
                                                    }
                                                  } else {
                                                    myAlertDialog(
                                                        message:
                                                        'Select Your Start Date First',
                                                        context: context);
                                                  }
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5),
                                                      color: appColors
                                                          .cAEB0C3
                                                          .withOpacity(
                                                          0.17)),
                                                  child: Text(
                                                      endDateController
                                                          .text
                                                          .isEmpty
                                                          ? DateTime.now()
                                                          .convertToYYYYMMDD()
                                                          : endDateController
                                                          .text,
                                                      style: appTextStyles
                                                          .p167003131
                                                          .copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w500)),
                                                ),
                                              ),
                                              5.horizontalSpace,
                                              if (!(repeat ==
                                                  'Three Times a Day (8am, 1pm & 5pm)' ||
                                                  repeat ==
                                                      'Twice a Day (8am &, 5pm)'))
                                                Visibility(
                                                  visible: !switchButton,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      FocusManager
                                                          .instance
                                                          .primaryFocus
                                                          ?.unfocus();
                                                      if (startTime !=
                                                          null &&
                                                          startDate !=
                                                              null) {
                                                        var time =
                                                        await showTimePicker(
                                                          context:
                                                          context,
                                                          initialTime: TimeOfDay.fromDateTime(DateTime(
                                                              1,
                                                              1,
                                                              1,
                                                              startTime
                                                                  ?.hour ??
                                                                  0,
                                                              startTime
                                                                  ?.minute ??
                                                                  0)),
                                                        );
                                                        if (time !=
                                                            null) {
                                                          bool
                                                          isStartTimeBeforeEndTime =
                                                          isTime1EarlierThanTime2(
                                                              "${startTime?.hour}:${startTime?.minute}",
                                                              "${time.hour}:${time.minute}");
                                                          if (isStartTimeBeforeEndTime ==
                                                              true) {
                                                            endTimeController
                                                                .text =
                                                                "${time.hour}:${time.minute}"
                                                                    .convertToAmPm();
                                                          } else {
                                                            endTimeController
                                                                .clear();
                                                            myAlertDialog(
                                                                message:
                                                                "End time must be after start time.",
                                                                context:
                                                                context);
                                                          }
                                                        }
                                                      } else {
                                                        myAlertDialog(
                                                            message:
                                                            'Select Your Start Time And Date First',
                                                            context:
                                                            context);
                                                        // Get.snackbar('Alert',
                                                        //     'Select your start time and date first');
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10,
                                                          vertical:
                                                          5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5),
                                                          color: appColors
                                                              .cAEB0C3
                                                              .withOpacity(
                                                              0.17)),
                                                      child: Text(
                                                          endTimeController
                                                              .text
                                                              .isEmpty
                                                              ? DateTime
                                                              .now()
                                                              .convertToYYYYMMDDWithTime()
                                                              : endTimeController
                                                              .text,
                                                          style: appTextStyles
                                                              .p167003131
                                                              .copyWith(
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            5.h.verticalSpace,
                            AppDropDownWidget(
                              options:
                              // endRepeat == null || endRepeat == "0"
                              //     ? []
                              //     :
                              [
                                      "None",
                                      "1 day before",
                                      "3 day before",
                                      "1 week before",
                                      "1 month before",
                                    ],
                              selectedTitle: alert,
                              title: 'Alert',
                              onChanged: (p0) {
                                alert = p0;
                                controller.update();
                              },
                            ),
                            12.h.verticalSpace,
                            Padding(
                              padding: EdgeInsets.only(left: 7.w, bottom: 8.h),
                              child: Text('Add Images or Files'),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: multipleSelectedImage.length +
                                      galleryImages.length + fileNames.length+
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
                                                      multipleSelectedImage
                                                          .addAll(images
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
                                                  shape: BoxShape.circle),
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
                                                  padding: EdgeInsets.only(
                                                      right: 4.0),
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
                            Padding(
                              padding: EdgeInsets.only(left: 3.w, top: 10.h),
                              child: Text(
                                'Note',
                                style: appTextStyles.p14400313131,
                              ),
                            ),
                            11.h.verticalSpace,
                            TextFormField(
                              controller: noteController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: appTextStyles.p16400AEB0C3,
                              maxLines: 3,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.r)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: appColors.c1E4475,
                                  ),
                                ),
                                hintText: " Type here...",
                                hintStyle: appTextStyles.p16400ADB,
                              ),
                              cursorColor: appColors.c1E4475,
                            ),
                            15.h.verticalSpace,
                            AppBlueButton(
                              title: 'Edit Event',
                              onTap: () async {
                                      if (startDate == null) {
                                      myAlertDialog(
                                          message:
                                          'Please Select Your Event Start Date',
                                          context: context);
                                    }
                                    //   else if (startTimeController
                                    //     .text.isEmpty &&
                                    //     !switchButton) {
                                    //   myAlertDialog(
                                    //       message:
                                    //       'Please Select Your Event Start Time',
                                    //       context: context);
                                    //   // Get.snackbar("Alert",
                                    //   //     'Please select your event start time');
                                    // }
                                    //   else if (endTimeController
                                    //     .text.isEmpty &&
                                    //     !switchButton) {
                                    //   myAlertDialog(
                                    //       message:
                                    //       'Please Select Your Event End Time',
                                    //       context: context);
                                    //   // Get.snackbar("Alert",
                                    //   //     'Please select your event end time');
                                    // }
                                      else if (repeat == null) {
                                      myAlertDialog(
                                          message:
                                          'Please Select Your Event Repeat',
                                          context: context);
                                    }
                                    //   else if (endRepeat?.toLowerCase() ==
                                    //     'on date' &&
                                    //     endDateController.text.isEmpty) {
                                    //   myAlertDialog(
                                    //       message:
                                    //       'Please Select Your Event End Date',
                                    //       context: context);
                                    // }
                                      else if (alert == null) {
                                      myAlertDialog(
                                          message:
                                          'Please Select Your Event Alert',
                                          context: context);
                                    } else {
                                  await showDialog(
                                    context: context,
                                    builder: (cnt) => Dialog(
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Save",
                                              style:
                                                  appTextStyles.p164001EBlue,
                                            ),
                                            15.h.verticalSpace,
                                            InkWell(
                                              onTap: () async {
                                                Get.back();
                                                try {
                                                  var res = await edit(
                                                      isEditThisOrAllZeroOne:
                                                          0);
                                                  if (res == true) {
                                                    Get.back();
                                                  }
                                                } catch (e) {
                                                  myAlertDialog(
                                                      message: e.toString(),
                                                      context: context);
                                                  // Get.snackbar("Error", "$e");
                                                }
                                              },
                                              child: Text(
                                                "This Event",
                                                style:
                                                    appTextStyles.p164008183,
                                              ),
                                            ),
                                            15.h.verticalSpace,
                                            InkWell(
                                              onTap: () async {
                                                Get.back();
                                                try {
                                                  var res = await edit(
                                                      isEditThisOrAllZeroOne:
                                                          1);
                                                  Get.back();
                                                  if (res == true) {
                                                    Get.back();
                                                  }
                                                } catch (e) {
                                                  myAlertDialog(
                                                      message: e.toString(),
                                                      context: context);
                                                  // Get.snackbar("Error", "$e");
                                                }
                                              },
                                              child: Text(
                                                "All events in series",
                                                style:
                                                    appTextStyles.p164008183,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
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
              );
            }),
      ),
    );
  }

  Future<bool?> edit({required int isEditThisOrAllZeroOne}) async {
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
      print('id ==>> $horseId');
      await calendarController.addEditEvent(
        id: calendarController.data.id.toString()??'1',
        isUpdateAllZeroOne: isEditThisOrAllZeroOne == 0 ? "0" : "1",
        horseId: [int.parse(horseId ?? "0")],
        contactId: contactId,
        location: locationController.text,
        categoryId: eventTypeId,
        startDate: startDateController.text.convertDateFormatToYYYYMMDD(),
        // startTime: startTimeController.text.to24HourFormat(),
        // endTime: endTimeController.text.to24HourFormat(),
        startTime:
        switchButton||(repeat == 'Three Times a Day (8am, 1pm & 5pm)'||repeat=='Twice a Day (8am &, 5pm)')
            ? null
            : startTimeController.text
            .to24HourFormat(),
        endTime:
        switchButton||(repeat == 'Three Times a Day (8am, 1pm & 5pm)'||repeat=='Twice a Day (8am &, 5pm)')
            ? null
            : endTimeController.text
            .to24HourFormat(),
        repeat: repeat,
        // repeat occurrences
        alert: alert,
        notes: noteController.text,
        eventTypeId: calendarController
            .eventTypeWithCategoryList[firstTabSelectedIndex ?? 0].id
            .toString(),
        // eventTypeId: calendarController.eventForEdit?.eventTypeId.toString(),
        endDate: (endRepeat == "Never"||repeat == "Never")?null:endDateController.text.convertDateFormatToYYYYMMDD(),
        removeFileIds: removeListImageIds, galleryImage: galleryU8,
        // specificDate:  date?.convertDateFormatToYYYYMMDD(),
        specificDate: isEditThisOrAllZeroOne == 0
            ? date?.convertDateFormatToYYYYMMDD()
            : null,
        galleryPdfU8: fileNames.isNotEmpty
            ? galleryPdfU8
            : [],
      );
      // return true;
    } catch (e) {
      rethrow;
    }
  }
}

