import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/horse_bio_data_model.dart';

class HorseInfoItems extends StatelessWidget {
  const HorseInfoItems({super.key, required this.horseBioDataList});

  final List<HorseBioDataModel> horseBioDataList;

  @override
  Widget build(BuildContext context) {
    int listLength = horseBioDataList.length;
    var amFeed = horseBioDataList[listLength - 1];
    var pmFeed = horseBioDataList[listLength - 2];
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: appColors.cE5E7F4, // Set the border color
                      width: 1.0,         // Set the border width
                    ),
                  ),
                    color: Colors.white
                ),

                                child: Column(
                children: [
                  20.h.verticalSpace,
                  pmFeed.icon == null
                      ? Container()
                      : SvgPicture.asset(
                          pmFeed.icon ?? "",
                          width: 65.w,
                          height: 65.h,
                        ),
                  11.h.verticalSpace,
                  Text(
                    pmFeed.title ?? "N/A",
                    style: appTextStyles.p14500AEB0C3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      pmFeed.info ?? "N/A",
                      style: appTextStyles.p18500313131.copyWith(
                        fontWeight: FontWeight.w700,
                        // overflow: TextOverflow.ellipsis
                      ),
                      // maxLines: 3,
                    ),
                  ),
                  25.h.verticalSpace,
                ],
                                ),
                              ),
              ),
              // SizedBox(width: 2, child: Container(color: Colors.red,height: 100,),),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: appColors.cE5E7F4, // Set the border color
                            width: 1.0,         // Set the border width
                          ),
                        ),
                        color: Colors.white
                    ),
                child: Column(
                  children: [
                    20.h.verticalSpace,
                    amFeed.icon == null
                        ? Container()
                        : SvgPicture.asset(
                            amFeed.icon ?? "",
                            width: 65.w,
                            height: 65.h,
                          ),
                    11.h.verticalSpace,
                    Text(
                      amFeed.title ?? "N/A",
                      style: appTextStyles.p14500AEB0C3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        amFeed.info ?? "N/A",
                        style: appTextStyles.p18500313131.copyWith(
                          fontWeight: FontWeight.w700,
                          // overflow: TextOverflow.ellipsis
                        ),
                        // maxLines: 3,
                      ),
                    ),
                    25.h.verticalSpace,
                  ],
                ),
              )),
            ],
          ),
        ),
        2.verticalSpace,
        // SizedBox(height:20, width :100,),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1.3,
            crossAxisSpacing: 1.3,
          ),
          itemCount: listLength - 2,
          itemBuilder: (context, index) {
            var singleItem = horseBioDataList[index];
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  singleItem.icon == null
                      ? Container()
                      : SvgPicture.asset(
                          singleItem.icon ?? "",
                          width: 65.w,
                          height: 65.h,
                        ),
                  11.h.verticalSpace,
                  Text(
                    singleItem.title ?? "N/A",
                    style: appTextStyles.p14500AEB0C3,
                  ),
                  5.h.verticalSpace,
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      // scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          singleItem.info ?? "N/A",
                          style: appTextStyles.p18500313131.copyWith(
                            fontWeight: FontWeight.w700,
                            // overflow: TextOverflow.ellipsis
                          ),
                          // maxLines: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        2.verticalSpace
      ],
    );
  }
}
