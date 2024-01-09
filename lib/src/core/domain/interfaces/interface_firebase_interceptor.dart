import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';

abstract class IFirebaseDBInterceptor {

  FirebaseAuth getAuth();

  String getDocumentId({
    required String collectionName,
  });

  Future<ApiResponse> readDocument({
    required String collectionName,
    required String documentId,
  });

  Future<ApiResponse> readCollection({
    required String collectionName,
  });


  Future<ApiResponse> insertCollection({
    required String collectionName,
    required Map<String, dynamic> json,
  });

  Future<ApiResponse> insertDocument({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> json,
    bool mergeData = false,
  });

  Future<ApiResponse> delete({
    required String endPoint,
    Map<String, String>? headers,
    dynamic body,
  });

  Future<ApiResponse> put({
    required String endPoint,
    Map<String, String>? headers,
    dynamic body,
  });

  Future<ApiResponse> uploadPhoto({
    required String filePath,
    required String folderName,
    required String fileName,
  });

}
