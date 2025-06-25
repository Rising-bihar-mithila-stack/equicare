import 'package:dio/dio.dart';

class ApiException {
  static final ApiException _singleton = ApiException._internal();

  factory ApiException() {
    return _singleton;
  }

  ApiException._internal();

  List<String> errors = [];
  List<String> getExceptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return [
          "Bad Response Error"
              "Check Api url or parameters are invalid"
        ];
      case DioExceptionType.connectionError:
        return ["Connection Error", "Check network Connectivity!"];
      case DioExceptionType.connectionTimeout:
        return ["Connection Timeout", "Check network Connectivity!"];
      case DioExceptionType.cancel:
        return ["Request Cancelled", "Check API url or parameters are invalid"];
      case DioExceptionType.receiveTimeout:
        return [
          "Receive Timeout",
          "Check API url, Network Connectivity or parameters are invalid"
        ];
      default:
        return [
          "Unknown Error Check API url",
          "Check API url or parameters are invalid"
        ];
    }
  }
}
