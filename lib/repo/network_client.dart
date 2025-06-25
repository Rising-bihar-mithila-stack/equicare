import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equicare/repo/api_exceptions.dart';
import 'package:get/get.dart' as getX;

import '../utils/constants/app_constants.dart';
import 'app_preferences.dart';

class NetworkClient {
  static final NetworkClient _singleton = NetworkClient._internal();

  factory NetworkClient() {
    return _singleton;
  }

  NetworkClient._internal();

  final _dio = appDio;
  var header = {
    'Authorization': 'Bearer ',
  };
  Future<void> getHeader() async {
    if (authToken != null) {
      header = {
        'Authorization': 'Bearer $authToken',
        // 'Content-Type': 'multipart/form-data',
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "*/*"
      };
    } else {
      var token = await AppPreferences().getToken();
      header = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Content-Type': 'multipart/form-data',
        "Accept": "*/*"
      };
    }
    log("header ---> $header");
  }

  Future<Response> createGetRequestWithHeader(
      {required String url, Map<String, dynamic>? data}) async {
    await getHeader();
    try {
      Response res = await _dio.get(url,
          data: data,
          options: Options(
            headers: header,
            validateStatus: (statusCode) {
              if (statusCode == null) {
                return false;
              }
              if (statusCode == 401) {
                //   http status code on which it should return true
                return true;
              } else {
                return statusCode >= 200 && statusCode < 300;
              }
            },
          ));
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(res.data);
      log("getRes url $url || body ---> $data  \n $prettyprint");
      if (res.statusCode == 401) {
        // getX.Get.toNamed(appRouteNames.loginScreen);
        getX.Get.toNamed(appRouteNames.onboardingScreen);
        //  getX. Get.snackbar("Alert", res.data["message"]);
      }
      if (res.data["status"] == 0) {
        throw res.data["message"];
      } else {
        return res;
      }
    } catch (e) {
      log("Get ERROR $url ->  | $e");
      if (e is DioException) {
        var errors = ApiException().getExceptionMessage(e);
        throw errors;
      }
      rethrow;
    }
  }

  Future<Response> createPostRequestWithHeader({
    required String url,
    required dynamic data,
  }) async {
    await getHeader();
    try {
      Response res = await _dio.post(url,
          data: data,
          options: Options(
            headers: header,
            validateStatus: (statusCode) {
              if (statusCode == null) {
                return false;
              }
              if (statusCode == 422) {
                // your http status code
                return true;
              } else {
                return statusCode >= 200 && statusCode < 300;
              }
            },
          ));
      //  log("");
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(res.data);
      log("postRes url $url body ---> $data  header $header \n $prettyprint");
      Map<String, dynamic> resdata = res.data;
      if (resdata.containsKey("message") &&
          resdata.containsKey("status") &&
          res.statusCode == 422) {
        if (resdata["status"].toString().toLowerCase().contains("error")) {
          throw resdata["message"].toString();
        }
      }
      if (resdata.containsKey("status") && resdata["status"] == 0) {
        throw resdata["message"].toString();
      }
      return res;
    } catch (e) {
      log("postERROR $url -> | data --> $data | $e");
      if (e is DioException) {
        var errors = ApiException().getExceptionMessage(e);
        throw errors;
      }
      rethrow;
    }
  }

  Future<Response> createPostRequestWithoutHeader({
    required String url,
    required Object data,
  }) async {
    log("url ---> $url");
    try {
      Response res = await _dio.post(url,
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "*/*"
            },
            validateStatus: (statusCode) {
              if (statusCode == null) {
                return false;
              }
              if (statusCode == 422) {
                // your http status code
                return true;
              } else {
                return statusCode >= 200 && statusCode < 300;
              }
            },
          ));
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(res.data);
      log("postResWtotHeader url $url body ---> $data  \n $prettyprint");
      Map<String, dynamic> resdata = res.data;
      if (resdata.containsKey("message") &&
          resdata.containsKey("status") &&
          res.statusCode == 422) {
        if (resdata["status"].toString().toLowerCase().contains("error")) {
          throw resdata["message"].toString();
        }
      }
      return res;
    } catch (e) {
      log("postERRORwithoutError ---> $url -> $e");
      if (e is DioException) {
        var errors = ApiException().getExceptionMessage(e);
        throw errors;
      }
      rethrow;
    }
  }

  Future<Response> createPostRequestWithCustomHeader({
    required String url,
    required dynamic data,
    dynamic header,
  }) async {
    try {
      Response res = await _dio.post(url,
          data: data,
          options: Options(
            headers: header ??
                {
                  'Authorization': 'Bearer $authToken',
                  Headers.contentTypeHeader:
                      'multipart/form-data; charset=UTF-8',
                  "Accept": "*/*",
                },
            validateStatus: (statusCode) {
              if (statusCode == null) {
                return false;
              }
              if (statusCode == 422) {
                // your http status code
                return true;
              } else {
                return statusCode >= 200 && statusCode < 300;
              }
            },
          ));
      log("postRes $url -> | $res");
      Map<String, dynamic> resdata = res.data;
      if (resdata.containsKey("message") &&
          resdata.containsKey("status") &&
          res.statusCode == 422) {
        if (resdata["status"].toString().toLowerCase().contains("error")) {
          throw resdata["message"].toString();
        }
      }
      return res;
    } catch (e) {
      log("postERROR $url -> | $e");
      if (e is DioException) {
        var errors = ApiException().getExceptionMessage(e);
        throw errors;
      }
      rethrow;
    }
  }

  Future<Response> createPutRequestWithHeader({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    await getHeader();
    log("putBody $url -> $data");
    try {
      Response res = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: header,
          validateStatus: (statusCode) {
            if (statusCode == null) {
              return false;
            }
            if (statusCode == 422) {
              // your http status code
              return true;
            } else {
              return statusCode >= 200 && statusCode < 300;
            }
          },
        ),
      );
      log("putRes $url -> $res");
      return res;
    } catch (e) {
      log("putERROR $url -> $e");
      if (e is DioException) {
        var errors = ApiException().getExceptionMessage(e);
        throw errors;
      }
      rethrow;
    }
  }
}
