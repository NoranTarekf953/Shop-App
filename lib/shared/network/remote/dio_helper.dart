// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:dio/dio.dart';


class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> getData({
    required String url,
     Map<String, dynamic>? query,
    String lang = 'en',
    String token = '',
  }) async {
    try {
      if (token != "" && token != null) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'lang': lang,
         'Authorization': token};
      }

      return await dio.get(url, queryParameters: query);
    } catch (e) {
      print('error in getData${e.toString()}');
      // Rethrow the error so that it can be caught by the calling function
      rethrow;
    }
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    try {
      if (token != "" && token != null) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'lang': lang,
           'Authorization': token
           };
      }
      return await dio.post(url, queryParameters: query, data: data);
    } catch (e) {
      print('error in postData${e.toString()}');
      // Rethrow the error so that it can be caught by the calling function
      rethrow;
    }
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    try {
      if (token != "" && token != null) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'lang': lang,
           'Authorization': token
           };
      }
      return await dio.put(
        url, 
        queryParameters: query,
         data: data);
    } catch (e) {
      print('error in putData${e.toString()}');
      // Rethrow the error so that it can be caught by the calling function
      rethrow;
    }
  }
}
