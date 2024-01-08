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
  Future<ApiResponse> readDocument({required String collectionName, required String documentId,}) async {
    DocumentSnapshot docSnap = await db.collection(collectionName).doc(documentId).get();
    if(docSnap.exists){
      return ApiResponse(statusCode: 200, result: docSnap.data());
    }else{
      return ApiResponse(statusCode: 404,);
    }
  }

  @override
  Future<ApiResponse> insertCollection({
    required String collectionName,
    required Map<String, dynamic> json,
  }) {
    // TODO: implement insertCollection
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> insertDocument({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> json,
  }) async{
    try{
      await db.collection(collectionName).doc(documentId).set(json);
      return ApiResponse(statusCode: 200, result: "Saved Successfully!",);

    }catch(e){
      return ApiResponse(statusCode: 400, result: "Failed to update profile!",);
    }
  }
}
