import 'dart:convert';
import 'package:equicare/features/my_calendar/controller/calendar_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/map_res_model.dart';

class GoogleMapSearchPlacesApi extends StatefulWidget {
  const GoogleMapSearchPlacesApi({Key? key}) : super(key: key);

  @override
  _GoogleMapSearchPlacesApiState createState() => _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
  final _controller = TextEditingController();
  CalendarController calendarController = CalendarController();
  final dio = Dio();
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    getSuggestion(_controller.text);
    setState(() {});
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = "your api key";
    calendarController.isLoading.value = true;

    try {
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$PLACES_API_KEY';

      Response response = await dio.get(request);
      var data = response.data;

      if (kDebugMode) {
        print('mydata');
        print(data);
      }

      if (response.statusCode == 200) {
        List<dynamic> predictionsJson = data['predictions'];
        setState(() {
          _placeList = predictionsJson.map((json) => PlacePrediction.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }finally{
      calendarController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: const Text('Search places Api'),
      // ),
      appBar: AppBar(
        
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Column(
            children: [
              7.verticalSpace,
              Align(
                alignment: Alignment.topCenter,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Search your location here",
                    focusColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon:  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(Icons.location_on_rounded),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _controller.clear();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: TextField(
          //     controller: _controller,
          //     decoration: InputDecoration(
          //       hintText: "Search your location here",
          //       focusColor: Colors.white,
          //       floatingLabelBehavior: FloatingLabelBehavior.never,
          //       prefixIcon: const Icon(Icons.location_on_rounded),
          //       suffixIcon: IconButton(
          //         icon: const Icon(Icons.cancel),
          //         onPressed: () {
          //           _controller.clear();
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child:calendarController.isLoading.value?Center(child: CircularProgressIndicator(),):_placeList.isEmpty?Center(child: Text("Not found"),) : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                final place = _placeList[index] as PlacePrediction;
                return GestureDetector(
                  onTap: () async {
                    calendarController.locationController.text = place.structuredFormatting.secondaryText;
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text(place.description),
                    subtitle: Text(place.structuredFormatting.secondaryText),
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}
