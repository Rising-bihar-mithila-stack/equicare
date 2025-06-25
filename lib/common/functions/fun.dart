import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Future<XFile?> getImage(ImageSource source) async {
  try {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: source, imageQuality: 10);
    return image;
  } catch (e) {
    throw 'error ============== >>>>>>> $e';
  }
}

Future<List<XFile>> getImages() async {
  final pickedFile = await ImagePicker().pickMultiImage(
      imageQuality: 10, // To set quality of images
      maxHeight: 1000, // To set maxheight of images that you want in your app
      maxWidth: 1000); // To set maxheight of images that you want in your app
  List<XFile> xfilePick = pickedFile;
  return xfilePick;
}

Future<List<dio.MultipartFile>> createUniqueMultipartFiles(
    List<Uint8List> filePaths) async {
  final List<dio.MultipartFile> files = [];
  final Random random = Random();

  for (var filePath in filePaths) {
    final int uniqueNumber = random.nextInt(999999);
    final String filename = "$uniqueNumber.png";

    try {
      var multipartFile = dio.MultipartFile.fromBytes(
        filePath,
        filename: filename,
        contentType: MediaType('image', 'png'),
      );
      files.add(multipartFile);
    } catch (e) {
      print("Error processing file $filePath: $e");
    }
  }
  return files;
}

bool isTime1EarlierThanTime2(String time1, String time2) {
  // Define the input format
  final DateFormat format = DateFormat('HH:mm');

  try {
    // Parse the time strings into DateTime objects
    DateTime time1DateTime = format.parse(time1);
    DateTime time2DateTime = format.parse(time2);

    // Compare the DateTime objects
    return time1DateTime.isBefore(time2DateTime);
  } catch (e) {
    // Handle parsing errors or invalid formats
    print('Error parsing time: $e');
    return false; // or true depending on how you want to handle errors
  }
}

String? getRemainingTimeOfEvent(
    {required String startTime, required String endTime}) {
  String startTimeStr = startTime;
  String endTimeStr = endTime;
  if (startTime == "00:00:00" && endTime == "23:59:59") {
    return "All day";
  }
  // Get the current time
  DateTime now = DateTime.now();

  // Parse the start and end times
  DateTime todayStart = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(startTimeStr.split(':')[0]),
      int.parse(startTimeStr.split(':')[1]),
      int.parse(startTimeStr.split(':')[2]));
  DateTime todayEnd = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(endTimeStr.split(':')[0]),
      int.parse(endTimeStr.split(':')[1]),
      int.parse(endTimeStr.split(':')[2]));

  // Determine the status
  String? status;
  Duration? remainingTime;

  if (now.isBefore(todayStart)) {
    // Time is before the start time
    remainingTime = todayStart.difference(now);

    if (remainingTime.inMinutes == 0) {
      return "Ongoing";
    } else if (remainingTime.inMinutes > 60) {
      status = "${remainingTime.inHours} hour left";
    } else {
      status = "${remainingTime.inMinutes} min left";
    }
  } else if (now.isAfter(todayEnd)) {
    // Time is after the end time
    status = "Over";
  } else {
    // Time is between start time and end time
    status = "Ongoing";
  }
  return status;
}

Future<List<dio.MultipartFile>> createUniquePdfMultipartFiles(
    List<Uint8List> filePaths) async {
  final List<dio.MultipartFile> files = [];
  final Random random = Random();

  for (var filePath in filePaths) {
    // Generate a unique filename with a .pdf extension
    final int uniqueNumber = random.nextInt(999999);
    final String filename = "file_$uniqueNumber.pdf";

    try {
      var multipartFile = dio.MultipartFile.fromBytes(
        filePath,
        filename: filename,
        contentType: MediaType('application', 'pdf'), // Set correct MIME type for PDFs
      );
      files.add(multipartFile);
    } catch (e) {
      print("Error processing file $filename: $e");
    }
  }
  return files;
}
