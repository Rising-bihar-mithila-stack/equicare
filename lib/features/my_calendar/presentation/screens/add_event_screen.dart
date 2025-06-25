import 'dart:io';
import 'dart:typed_data';
import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/drop_downs/app_dropdown.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/my_calendar/controller/calendar_controller.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/functions/fun.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../common/widgets/image_select_bottom_sheet_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../contacts/model/contact_model.dart';
import '../../../my_stable/models/my_stable_model.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int firstTabSelectedIndex = 0;
  bool switchButton = false;
  late CalendarController calendarController;
  String? selectedHorseName;
  String? selectedContactName;
  String? selectedEvent;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
   TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? startDate = DateTime.now();
  TimeOfDay? startTime;
  String? eventTypeId;
  String? horseId;
  String? contactId;
  String? repeat;
  String? endRepeat;
  String? alert;

  List<XFile> fileNames = [];
  List<XFile> mSelectedImage = [];
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    calendarController = Get.put(CalendarController());
    calendarController.mySelectedHorsesName = '';
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        calendarController.getEventType();
        calendarController.clearData();
        calendarController.selectedEventHealth = null;
        calendarController.getEventFields(
            eventTypeId: "${1}", isFromTab: false);
        startTimeController.text = "${startDate?.hour}:${startDate?.minute}"
            .convertToAmPm();
        endTimeController.text = "${startDate?.hour}:${startDate?.minute}"
            .convertToAmPm();
        startDateController
            .text =
            "${startDate?.day}/${startDate?.month}/${startDate?.year}"
                .convertDateFormatToDMYYYY();
        endDateController.text =
        "${startDate?.day}/${startDate?.month}/${startDate?.year}";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
            init: calendarController,
            builder: (controller) {
              return ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
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
                          'Add Event',
                          textAlign: TextAlign.center,
                          style: appTextStyles.p308002E2E,
                        ),
                        SizedBox(
                          width: 40.w,
                        )
                      ],
                    ),
                    10.h.verticalSpace,
                    const AppAppBarShadowWidget(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  itemCount: controller
                                      .eventTypeWithCategoryList.length,
                                  itemBuilder: (context, index) {
                                    var eventType = controller
                                        .eventTypeWithCategoryList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        firstTabSelectedIndex = index;
                                        controller.selectedEventHealth = null;
                                        controller.getEventFields(
                                            eventTypeId: "${index + 1}",
                                            isFromTab: true);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13),
                                        decoration: firstTabSelectedIndex ==
                                                index
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
                                                  .copyWith(
                                                      color: appColors.cAEB0C3),
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
                                  GetBuilder(
                                      init: calendarController,
                                      id: "assignHorse",
                                      builder: (controle) {
                                        return InkWell(
                                          onTap: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();

                                            if (controller
                                                .myStableList.isNotEmpty) {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    appColors.cF6F6F6,
                                                context: context,
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Select Horses',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: appTextStyles
                                                                .p26500313131
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          10.verticalSpace,
                                                          GetBuilder(
                                                              init:
                                                                  calendarController,
                                                              id: "assignHorse",
                                                              builder: (cont) {
                                                                return ListView
                                                                    .builder(
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .myStableList
                                                                          .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    var st = cont
                                                                            .myStableList[
                                                                        index];
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          Card(
                                                                        color: appColors
                                                                            .white,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 20.w).copyWith(right: 10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("${st.name}"),
                                                                              Checkbox(
                                                                                activeColor: appColors.primaryBlueColor,
                                                                                // fillColor: WidgetStatePropertyAll(Colors.amber),
                                                                                value: st.isSelected ?? false,
                                                                                onChanged: (value) {
                                                                                  controller.selectHorse(id: st.id ?? 0, val: !(st.isSelected ?? false));
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child:
                                                                AppBlueButton(
                                                              title: 'Done',
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              myAlertDialog(
                                                  message:
                                                      "Add the horse first before adding any events.",
                                                  context: context);
                                            }
                                          },
                                          child: AppDropDownWidget(
                                            options: const [],
                                            title: 'Horse',
                                            selectedTitle: controller
                                                    .mySelectedHorsesName
                                                    .isNotEmpty
                                                ? controller
                                                    .mySelectedHorsesName
                                                    .substring(
                                                        0,
                                                        controller
                                                                .mySelectedHorsesName
                                                                .length -
                                                            2)
                                                : null,
                                            onChanged: (p0) {
                                              if (p0 is MyStableModel) {
                                                horseId = p0.id.toString();
                                                selectedHorseName = p0.name;
                                              }
                                            },
                                          ),
                                        );
                                      }),
                                  14.h.verticalSpace,
                                  controller.contactList.isEmpty
                                      ? InkWell(
                                          onTap: () {
                                            myAlertDialog(
                                                message:
                                                    "Add the contact first before adding any events.",
                                                context: context);
                                          },
                                          child: AppDropDownWidget(
                                            options: const [],
                                            selectedTitle: selectedContactName,
                                            items: controller.contactList
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child:
                                                        Text("${e.fullName}"),
                                                  ),
                                                )
                                                .toList(),
                                            title: 'Contact',
                                            onChanged: (p0) {
                                              if (p0 is ContactModel) {
                                                selectedContactName =
                                                    p0.fullName;
                                                contactId = p0.id.toString();
                                              }
                                              controller.update();
                                            },
                                          ),
                                        )
                                      : AppDropDownWidget(
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
                                            }
                                            controller.update();
                                          },
                                        ),
                                  6.h.verticalSpace,
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Get.to(GoogleMapSearchPlacesApi());
                                  //   },
                                  //   child:
                                  AppTextField(
                                      // isEnabled: false,
                                      hintText: 'Location',
                                      textEditingController: locationController,
                                      title: "Enter location"),
                                  6.h.verticalSpace,

// ================================================================================================================================================
                                  Column(
                                    children: [
                                      // Parent Dropdown
                                      Column(
                                        children: List.generate(
                                            controller.listOfEventTypes.length,
                                            (index) {
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
                                                        .listOfEventTypes[index]
                                                        .eventTypeId
                                                        .toString(),
                                                    fieldValue: p0,
                                                    fieldId: controller
                                                        .listOfEventTypes[index]
                                                        .id
                                                        .toString(),
                                                  );
                                                  calendarController
                                                      .clearlisttext();
                                                  controller.update();
                                                }
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                      // Child Fields

                                      // Child Dropdowns
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
                                              title:
                                                  field.label ?? 'Child Event',
                                              onChanged: (p0) async {
                                                // Add selected child value to the list
                                                controller.selectedValues
                                                    .add(p0);
                                                controller.selectedChildValue1 =
                                                    p0;
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
                                                calendarController
                                                    .clearlisttext();
                                                if (controller
                                                        .selectedChildValue1 !=
                                                    'Full') {
                                                  controller.radioButtonList
                                                      .clear();
                                                  controller
                                                          .selectedRadioOption =
                                                      null;
                                                }
                                              },
                                            ),
                                          );
                                        }),
                                      ),
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
                                              title:
                                                  field.label ?? 'Child Event',
                                              onChanged: (p0) async {
                                                controller.selectedChildValue2 =
                                                    p0;
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
                                                calendarController
                                                    .clearlisttext();
                                                controller.update();
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                      Column(
                                        children: controller.radioButtonList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index = entry.key;
                                          var radioButtonItem = entry.value;

                                          // Check if the type is 'radio' before displaying the custom widget
                                          return radioButtonItem.type == 'radio'
                                              ? RadioButtonGroup(
                                                  controller: controller,
                                                  eventId: controller
                                                      .radioButtonList[index]
                                                      .eventTypeId
                                                      .toString(),
                                                  fieldId: controller
                                                      .radioButtonList[index].id
                                                      .toString(),
                                                )
                                              : SizedBox(); // Empty space when the type is not 'radio'
                                        }).toList(),
                                      ),
                                      Column(
                                        children: List.generate(
                                            controller.listOfTextFormField
                                                .length, (index) {
                                          return Visibility(
                                            visible: controller
                                                    .listOfTextFormField[index]
                                                    .type ==
                                                'textbox',
                                            child: AppTextField(
                                              hintText: controller
                                                      .listOfTextFormField[
                                                          index]
                                                      .label ??
                                                  '',
                                              title: '',
                                              textEditingController: controller
                                                      .listOfTextEditingController[
                                                  index],
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
// ================================================================================================================================================

                                  4.h.verticalSpace,
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
                                      if (repeat == "Never") {
                                        endRepeat = null;
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
                                        const [
                                      // if date today the 15 min , 1 hr , if next day then 1 day before and so on
                                      "none",
                                      "15 min before",
                                      "1 hr before",
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
                                    padding: EdgeInsets.only(left: 7.w),
                                    child: const Text('Add Images or Files'),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 17),
                                    height: 100,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: mSelectedImage.length +
                                            fileNames.length +
                                            1,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return index == 0
                                              ? GestureDetector(
                                                  onTap: () {
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

                                                                for (var file
                                                                    in result
                                                                        .files) {
                                                                  XFile? xFile =
                                                                      file.xFile;
                                                                  print(
                                                                      'Adding file path: $xFile');

                                                                  if (xFile !=
                                                                      null) {
                                                                    if (xFile
                                                                        .path
                                                                        .contains(
                                                                            '.pdf')) {
                                                                      if (xFile
                                                                          .path
                                                                          .isNotEmpty) {
                                                                        fileNames
                                                                            .add(xFile);
                                                                      }
                                                                    } else {
                                                                      myAlertDialog(
                                                                          message:
                                                                              'Select Only PDF',
                                                                          context:
                                                                              context);
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
                                                            Navigator.pop(cnt);
                                                            var images =
                                                                await getImages();
                                                            mSelectedImage
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
                                                  // onTap: () async {
                                                  //   var images =
                                                  //       await getImages();
                                                  //   mSelectedImage.addAll(images
                                                  //       .map(
                                                  //         (e) => e,
                                                  //       )
                                                  //       .toList());
                                                  //   controller.update();
                                                  // },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    width: 95.w,
                                                    height: 88.h,
                                                    decoration: BoxDecoration(
                                                      color: appColors.cE6E6E6,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          appIcons.addIconSvg,
                                                          color:
                                                              appColors.c818393,
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
                                                    mSelectedImage.length >
                                                            index - 1
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .black12,
                                                              maxRadius: 48,
                                                              backgroundImage:
                                                                  FileImage(File(
                                                                      mSelectedImage[index -
                                                                              1]
                                                                          .path)),
                                                            ),
                                                          )
                                                        : Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .black12,
                                                              maxRadius: 48,
                                                              child: Icon(
                                                                Icons
                                                                    .picture_as_pdf_outlined,
                                                                size: 45,
                                                              ),
                                                            ),
                                                          ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (mSelectedImage
                                                                .length >
                                                            index - 1) {
                                                          mSelectedImage
                                                              .removeAt(
                                                                  index - 1);
                                                        } else {
                                                          fileNames.removeAt(
                                                              index -
                                                                  mSelectedImage
                                                                      .length -
                                                                  1);
                                                        }
                                                        controller.update();
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
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
                                          // : Stack(
                                          //     alignment: Alignment.topRight,
                                          //     children: [
                                          //       Container(
                                          //         margin: const EdgeInsets
                                          //             .symmetric(
                                          //             horizontal: 5),
                                          //         child: CircleAvatar(
                                          //           maxRadius: 48,
                                          //           backgroundImage:
                                          //               FileImage(File(
                                          //                   mSelectedImage[
                                          //                           index -
                                          //                               1]
                                          //                       .path)),
                                          //         ),
                                          //       ),
                                          //       GestureDetector(
                                          //         onTap: () {
                                          //           mSelectedImage.removeAt(
                                          //               index - 1);
                                          //           controller.update();
                                          //         },
                                          //         child: const Padding(
                                          //           padding:
                                          //               EdgeInsets.only(
                                          //                   right: 4.0),
                                          //           child: Icon(
                                          //             Icons.remove_circle,
                                          //             size: 20,
                                          //             color: Colors.red,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   );
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 3.w, top: 3.h),
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
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        borderSide: BorderSide(
                                          color: appColors.cDFDFDF,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        borderSide: BorderSide(
                                          color: appColors.cDFDFDF,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.r)),
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
                                    title: 'Add Event',
                                    onTap: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      print("erepeat==>> ${endRepeat}");
                                      print("repeat==>> ${repeat}");
                                      if (controller
                                          .mySelectedHorsesName.isEmpty) {
                                        myAlertDialog(
                                            message: 'Please select your horse',
                                            context: context);
                                      } else if (startDate == null) {
                                        myAlertDialog(
                                            message:
                                                'Please Select Your Event Start Date',
                                            context: context);
                                      } else if (startTimeController
                                              .text.isEmpty &&
                                          !switchButton &&
                                          !(repeat ==
                                                  'Three Times a Day (8am, 1pm & 5pm)' ||
                                              repeat ==
                                                  'Twice a Day (8am &, 5pm)')) {
                                        myAlertDialog(
                                            message:
                                                'Please Select Your Event Start Time',
                                            context: context);
                                      } else if (endTimeController
                                              .text.isEmpty &&
                                          !switchButton &&
                                          !(repeat ==
                                                  'Three Times a Day (8am, 1pm & 5pm)' ||
                                              repeat ==
                                                  'Twice a Day (8am &, 5pm)')) {
                                        myAlertDialog(
                                            message:
                                                'Please Select Your Event End Time',
                                            context: context);
                                      } else if (repeat == null) {
                                        myAlertDialog(
                                            message:
                                                'Please Select Your Event Repeat',
                                            context: context);
                                      } else if ((repeat ==
                                                  'Three Times a Day (8am, 1pm & 5pm)' ||
                                              repeat ==
                                                  'Twice a Day (8am &, 5pm)') &&
                                          endDateController.text.isEmpty) {
                                        myAlertDialog(
                                            message:
                                                'Please Select Your Event End Date',
                                            context: context);
                                      } else if (alert == null) {
                                        myAlertDialog(
                                            message:
                                                'Please Select Your Event Alert',
                                            context: context);
                                      } else {
                                        List<Uint8List> galleryU8 = [];
                                        List<Uint8List> galleryPdfU8 = [];

                                        try {
                                          for (var file in mSelectedImage) {
                                            var u8 = await file.readAsBytes();
                                            galleryU8.add(u8);
                                          }
                                          for (var file in fileNames) {
                                            var u8 = await file.readAsBytes();
                                            galleryPdfU8.add(u8);
                                          }
                                          bool? res =
                                              await controller.addEditEvent(
                                            id: null,
                                            isUpdateAllZeroOne: null,
                                            horseId: calendarController
                                                .assignedHorsesForEvent,
                                            contactId: contactId ?? null,
                                            location: locationController.text
                                                .toString(),
                                            categoryId: eventTypeId,
                                            startDate: startDateController.text
                                                .convertDateFormatToYYYYMMDD(),
                                            startTime: switchButton ||
                                                    (repeat ==
                                                            'Three Times a Day (8am, 1pm & 5pm)' ||
                                                        repeat ==
                                                            'Twice a Day (8am &, 5pm)')
                                                ? null
                                                : startTimeController.text
                                                    .to24HourFormat(),
                                            endTime: switchButton ||
                                                    (repeat ==
                                                            'Three Times a Day (8am, 1pm & 5pm)' ||
                                                        repeat ==
                                                            'Twice a Day (8am &, 5pm)')
                                                ? null
                                                : endTimeController.text
                                                    .to24HourFormat(),
                                            repeat: repeat,
                                            // repeat occurrences
                                            alert: alert,
                                            notes: noteController.text,
                                            eventTypeId: controller
                                                .eventTypeWithCategoryList[
                                                    firstTabSelectedIndex]
                                                .id
                                                .toString(),
                                            endDate: (endRepeat == "Never" ||
                                                    repeat == "Never")
                                                ? startDateController.text
                                                .convertDateFormatToYYYYMMDD()
                                                  : endDateController.text
                                                    .convertDateFormatToYYYYMMDD(),
                                            removeFileIds: null,
                                            galleryImage: galleryU8,
                                            specificDate: null,
                                            galleryPdfU8: fileNames.isNotEmpty
                                                ? galleryPdfU8
                                                : [],
                                          );
                                          if (res == true) {
                                            Get.back();
                                          }
                                        } catch (e) {
                                          myAlertDialog(
                                              message: e.toString(),
                                              context: context);
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
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    noteController.dispose();
    calendarController.clearData();
    super.dispose();
  }
}

class RadioButtonGroup extends StatefulWidget {
  final CalendarController controller;
  final String eventId;
  final String fieldId;

  RadioButtonGroup(
      {required this.controller, required this.eventId, required this.fieldId});
  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        6.verticalSpace,
        Text(" ${widget.controller.radioButtonList[0].label}"),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Yes'),
                leading: Radio<String>(
                  value: 'Yes',
                  groupValue: widget.controller.selectedRadioOption,
                  onChanged: (String? value) async {
                    setState(() {
                      widget.controller.selectedRadioOption = value;
                    });
                    await widget.controller.getEventFieldsChild2(
                      eventTypeId: widget.eventId,
                      fieldValue: 'Yes',
                      fieldId: widget.fieldId,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('No'),
                leading: Radio<String>(
                  value: 'No',
                  groupValue: widget.controller.selectedRadioOption,
                  onChanged: (String? value) async {
                    setState(() {
                      widget.controller.selectedRadioOption = value;
                    });

                    await widget.controller.getEventFieldsChild2(
                      eventTypeId: widget.eventId,
                      fieldValue: 'No',
                      fieldId: widget.fieldId,
                    );
                    widget.controller.listOfTextFormField.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
