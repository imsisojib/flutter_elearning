import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';

import '../../domain/interfaces/interface_firebase_interceptor.dart';

class FirebaseDBInterceptor implements IFirebaseDBInterceptor {
  final FirebaseFirestore db;

  FirebaseDBInterceptor({
    required this.db,
  });

  @override
  Future<ApiResponse> delete({required String endPoint, Map<String, String>? headers, body}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> put({required String endPoint, Map<String, String>? headers, body}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> read({required String endPoint, Map<String, String>? headers, Map<String, dynamic>? body}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> insert({required String url, Map<String, String>? headers}) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
