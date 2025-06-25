import 'package:intl/intl.dart';

extension DateStringConversion on String {
  String convertDateFormatToYYYYMMDD() {
    try {
      // Define input and output date formats
      DateFormat inputFormat = DateFormat("d/M/yyyy");
      DateFormat outputFormat = DateFormat("yyyy-MM-dd");
      // Parse the date string using the input format
      DateTime parsedDate = inputFormat.parse(this);

      // Format the parsed date to the output format
      return outputFormat.format(parsedDate);
    } catch (e) {
      // Handle any parsing or formatting errors
      print('Error converting date format: $e');
      return this; // Return the original string if conversion fails
    }
  }
}

extension TimeStringConversion on String {
  String convertTimeFormatToHHmmss() {
    try {
      // Define input and output time formats
      DateFormat inputFormat = DateFormat("H:m");
      DateFormat outputFormat = DateFormat("HH:mm:ss");
      // Parse the time string using the input format
      DateTime parsedTime = inputFormat.parse(this);
      // Format the parsed time to the output format
      return outputFormat.format(parsedTime);
    } catch (e) {
      // Handle any parsing or formatting errors
      print('Error converting time format: $e');
      return this; // Return the original string if conversion fails
    }
  }

  String convertTimeFormatToHHmm() {
    try {
      // Define input and output time formats
      DateFormat inputFormat = DateFormat("H:m");
      DateFormat outputFormat = DateFormat("HH:mm:ss");
      // Parse the time string using the input format
      DateTime parsedTime = inputFormat.parse(this);
      // Format the parsed time to the output format
      return outputFormat.format(parsedTime);
    } catch (e) {
      // Handle any parsing or formatting errors
      print('Error converting time format: $e');
      return this; // Return the original string if conversion fails
    }
  }

  String convertDateFormatToDMYYYY() {
    try {
      // Define input and output date formats
      DateFormat inputFormat = DateFormat("yyyy-MM-dd");
      DateFormat outputFormat = DateFormat("d/M/yyyy");

      // Parse the date string using the input format
      DateTime parsedDate = inputFormat.parse(this);

      // Format the parsed date to the output format
      return outputFormat.format(parsedDate);
    } catch (e) {
      // Handle any parsing or formatting errors
      print('Error converting date format: $e');
      return this; // Return the original string if conversion fails
    }
  }

   String convertToAmPm() {
    // Create DateFormat objects for parsing and formatting
    final DateFormat inputFormat = DateFormat('H:m');
    final DateFormat outputFormat = DateFormat('h:mm a');

    try {
      // Parse the input time
      DateTime dateTime = inputFormat.parse(this);

      // Format the DateTime to 12-hour format with AM/PM
      return outputFormat.format(dateTime);
    } catch (e) {
      // Handle parsing errors or invalid formats
      return this;
    }
  }

  String to24HourFormat() {
    final input = this.trim();
    final regex = RegExp(r'^(0?[1-9]|1[0-2]):([0-5][0-9])\s*(AM|PM)$');

    final match = regex.firstMatch(input);
    if (match == null) {
      throw FormatException('Invalid time format. Expected "hh:mm:AM/PM".');
    }

    final hour = int.parse(match.group(1)!);
    final minute = match.group(2)!;
    final period = match.group(3)!;

    // Convert hour to 24-hour format
    int hour24;
    if (period == 'AM') {
      hour24 = (hour == 12) ? 0 : hour;
    } else { // PM case
      hour24 = (hour == 12) ? 12 : (hour + 12);
    }

    // Format the hour and minute into "HH:mm:ss"
    final formattedHour = hour24.toString().padLeft(2, '0');
    final formattedMinute = minute.padLeft(2, '0');
    final formattedSecond = '00'; // Fixed as seconds are not provided

    return '$formattedHour:$formattedMinute:$formattedSecond';
  }

  String toFormattedDateWithZero() {
    // Split the string by the dash character.
    final parts = this.split('-');

    // Ensure we have 3 parts (year, month, day).
    if (parts.length != 3) {
      return this; // or throw an exception if the format is not correct.
    }

    // Add leading zeros to the month and day if necessary.
    final year = parts[0];
    final month = parts[1].padLeft(2, '0');
    final day = parts[2].padLeft(2, '0');

    // Reassemble the date string in the "YYYY-MM-DD" format.
    return '$year-$month-$day';
  }
}
extension StringToUtcDateTime on String {
  DateTime toUtcDateTime() {
    // Parse the string to a DateTime object (assuming the string is in 'yyyy-MM-dd' format)
    final localDateTime = DateTime.parse(this);

    // Convert the local DateTime to UTC DateTime
    return localDateTime.toUtc();
  }
}

extension DateTimeConversion on DateTime {
  String convertToYYYYMMDD() {
    try {
      // Define output date format
      DateFormat outputFormat = DateFormat("d/MM/yyyy");

      // Format the DateTime object to the output format
      return outputFormat.format(this);
    } catch (e) {
      // Handle any formatting errors
      print('Error formatting date: $e');
      return this.toString(); // Return the original DateTime string if conversion fails
    }
  }
  String convertToYYYYMMDDWithTime() {
    try {
      // Define output date and time format (YYYY-MM-DD hh:mm a)
      DateFormat outputFormat = DateFormat("h:mm a");

      // Format the DateTime object to the output format
      return outputFormat.format(this);
    } catch (e) {
      // Handle any formatting errors
      print('Error formatting date and time: $e');
      return this.toString(); // Return the original DateTime string if conversion fails
    }
  }
}