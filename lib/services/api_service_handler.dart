import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;
import 'package:aajtak/exceptions/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* Singleton Class responsible for managing all the requests such as GET,POST,PUT,DELETE
*  */
enum RequestType { GET, POST, PUT, DELETE }

class ApiServiceHandler {
  //Needs to be changed

  static const int TIMEOUT_DURATION = 60;

  ApiServiceHandler._privateConstructor();

  static final ApiServiceHandler _instance =
      ApiServiceHandler._privateConstructor();

  factory ApiServiceHandler() {
    return _instance;
  }

  Options getOptions(Map<String, String>? finalHeaders, {String? contentType}) {
    return Options(
        headers: finalHeaders,
        contentType: contentType ?? 'application/json',
        responseType: ResponseType.json,
        receiveTimeout: 100000);
  }

  CacheOptions defaultCacheOptions() {
    return CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),
      // Default.
      policy: CachePolicy.request,
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended.
      allowPostMethod: false,
    );
  }

  Dio getDioInstance(bool addCacheInterceptor) {
    var dio = Dio();
    if (addCacheInterceptor) {
      dio.interceptors.add(DioCacheInterceptor(options: defaultCacheOptions()));
    }
    dio.options.connectTimeout = 60 * 1000;

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: securePrint, // specify log function (optional)
      retries: 3, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
    dio.interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        error: false,
        logPrint: securePrint));
    return dio;
  }

  void securePrint(Object? object) {
    /// do not print anything to standard output
    dev.log((object != null && object is String && object.isNotEmpty)
        ? object
        : '');
  }

  /*
  * GET OR DELETE Method request
  * */
  Future<dynamic> getOrDeleteDio(String baseUrl,
      {required String endpoint,
      Map<String, String>? headers,
      required RequestType requestType,
      Map<String, String>? queryParams,
      bool addCacheInterceptor = false}) async {
    var responseJson;
    final uri = Uri.parse(baseUrl + endpoint);
    try {
      dev.log('REQUEST TYPE GET ${uri.toString()}');
      Dio dio = getDioInstance(addCacheInterceptor);
      Response rawResponse;
      switch (requestType) {
        case RequestType.DELETE:
          rawResponse = await dio
              .delete(uri.toString(),
                  queryParameters: queryParams, options: getOptions(headers))
              .timeout(const Duration(seconds: TIMEOUT_DURATION));
          break;
        default:
          rawResponse = await dio
              .get(uri.toString(),
                  queryParameters: queryParams, options: getOptions(headers))
              .timeout(const Duration(seconds: TIMEOUT_DURATION));
      }
      ;
      responseJson = _getDioResponse(rawResponse);
    } on TimeoutException {
      throw FetchDataException('TimedOut Exception');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      _getDioResponse(e.response);
    }
    return responseJson;
  }

  /*
  * POST OR PUT Method request
  * */
  Future<dynamic> postOrPutDio(String baseUrl,
      {required String endpoint,
      required RequestType requestType,
      Map<String, String>? headers,
      @required Map<String, dynamic>? body,
      bool addCacheInterceptor = false,
      String? contentType}) async {
    var responseJson;
    final uri = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = getDioInstance(addCacheInterceptor);
      var rawResponse;
      switch (requestType) {
        case RequestType.PUT:
          Options options = getOptions(headers);
          options.method = 'PATCH';
          dev.log('REQUEST TYPE ${options.method} ${uri.toString()}');
          rawResponse = await dio
              .request(uri.toString(),
                  data: json.encode(body), options: options)
              .timeout(Duration(seconds: TIMEOUT_DURATION));
          break;
        default:
          dev.log('REQUEST TYPE POST ${uri.toString()}');
          rawResponse = await dio
              .post(uri.toString(),
                  data: getBody(body, contentType),
                  options: getOptions(headers, contentType: contentType))
              .timeout(Duration(seconds: TIMEOUT_DURATION));
      }
      responseJson = _getDioResponse(rawResponse);
    } on TimeoutException {
      throw FetchDataException('TimedOut Exception');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      _getDioResponse(e.response);
    }
    return responseJson;
  }

  /*
  * Parse response and throw errors based on the status code
  *  */
  dynamic _getDioResponse(Response<dynamic>? response) {
    switch (response!.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.created:
        var responseJson = response.data;
        dev.log(responseJson.toString());
        return responseJson;
      case HttpStatus.badRequest:
        throw BadRequestException(response.data.toString());
      case HttpStatus.unauthorized:
      case HttpStatus.forbidden:
        throw UnauthorisedException(response.data.toString());
      case HttpStatus.lengthRequired:
        throw throw PasswordChangeRequiredException(response.toString());
      case HttpStatus.internalServerError:
      case HttpStatus.notImplemented:
      case HttpStatus.badGateway:
      case HttpStatus.serviceUnavailable:
        throw ServerException(response.data.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode} and message ${response.data.toString()}');
    }
  }

  getBody(Map<String, dynamic>? body, String? contentType) {
    if (contentType == Headers.formUrlEncodedContentType)
      return body;
    else
      return json.encode(body);
  }
}
