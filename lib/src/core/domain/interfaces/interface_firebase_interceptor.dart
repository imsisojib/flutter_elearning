import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';

abstract class IFirebaseDBInterceptor{
  Future<ApiResponse> read({required String endPoint, Map<String,String>? headers,Map<String,dynamic>? body,});
  Future<ApiResponse> insert({required String url, Map<String,String>? headers,});
  Future<ApiResponse> delete({required String endPoint, Map<String,String>? headers,dynamic body,});
  Future<ApiResponse> put({required String endPoint, Map<String,String>? headers,dynamic body,});
}