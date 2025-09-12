import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../Local/cache_helper.dart';
import 'api_constance.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: ApiConstance.baseUrl,
          receiveDataWhenStatusError: true,
        ),
      )
      ..interceptors.addAll([
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 89,
          ),
      ]);
  }

  static Future<Response> getData({
    required String endPoint,
    String? refreshToken,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.get(key: 'token')}',
    };
    final response = await dio!.get(endPoint, queryParameters: query);
    return response;
  }

  static Future<Response> patchData({
    required String? endPoint,
    required dynamic data,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.get(key: 'token')}',
    };
    final response = await dio!.patch('$endPoint', data: data);
    return response;
  }

  static Future<Response> postData({
    required String endPoint,
    dynamic data,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.get(key: 'token')}',
    };

    final response = await dio!.post(
      '${ApiConstance.baseUrl}$endPoint',
      data: data,
    );
    return response;
  }

  static Future<Response> putData({
    required String endPoint,
    dynamic data,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.get(key: 'token')}',
    };

    final response = await dio!.put(
      '${ApiConstance.baseUrl}$endPoint',
      data: data,
    );

    return response;
  }

  static Future<Response> deleteData({
    required String endPoint,
    dynamic data,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.get(key: 'token')}',
    };
    final response = await dio!.delete(
      '${ApiConstance.baseUrl}$endPoint',
      data: data,
    );

    return response;
  }
}
