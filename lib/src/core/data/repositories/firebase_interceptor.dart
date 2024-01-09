import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';

import '../../domain/interfaces/interface_firebase_interceptor.dart';

class FirebaseDBInterceptor implements IFirebaseDBInterceptor {
  final FirebaseFirestore db;
  final FirebaseStorage storage;
  final FirebaseAuth auth;

  FirebaseDBInterceptor({
    required this.db,
    required this.storage,
    required this.auth,
  });

  @override
  FirebaseAuth getAuth() {
    return auth;
  }

  @override
  FirebaseFirestore getFirestore(){
    return db;
  }

  @override
  String getDocumentId({required String collectionName}) {
    return db.collection(collectionName).doc().id;
  }

  @override
  Future<ApiResponse> deleteDocument({required String collectionName, required String documentId,}) async {
    await db.collection(collectionName).doc(documentId).delete();
    return ApiResponse(statusCode: 200, result: "Deleted successfully.");
  }

  @override
  Future<ApiResponse> put({required String endPoint, Map<String, String>? headers, body}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> readDocument({
    required String collectionName,
    required String documentId,
  }) async {
    DocumentSnapshot docSnap = await db.collection(collectionName).doc(documentId).get();
    if (docSnap.exists) {
      return ApiResponse(statusCode: 200, result: docSnap.data());
    } else {
      return ApiResponse(
        statusCode: 404,
      );
    }
  }

  @override
  Future<ApiResponse> readCollection({required String collectionName}) async {
    QuerySnapshot querySnapshot = await db.collection(collectionName).get();
    if (querySnapshot.docs.isNotEmpty) {
      return ApiResponse(statusCode: 200, result: querySnapshot.docs);
    } else {
      return ApiResponse(
        statusCode: 404,
      );
    }
  }



  @override
  Future<ApiResponse> insertCollection({
    required String collectionName,
    required Map<String, dynamic> json,
    ///will use auto id

  }) async {
    try {
      await db.collection(collectionName).doc().set(json);
      return ApiResponse(
        statusCode: 200,
        result: "Saved Successfully!",
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        result: "Failed to save!",
      );
    }
  }

  @override
  Future<ApiResponse> insertDocument({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> json,
    bool mergeData = false,
  }) async {
    if(auth.currentUser?.uid==null){
      return ApiResponse(statusCode: 401, result: "Unauthorized User!",);
    }
    try {
      await db.collection(collectionName).doc(documentId).set(json, SetOptions(merge: mergeData,));
      return ApiResponse(
        statusCode: 200,
        result: "Saved Successfully!",
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        result: "Failed to save!",
      );
    }
  }

  @override
  Future<ApiResponse> uploadPhoto({
    required String filePath,
    required String fileName,
    required String folderName,
  }) async {
    try {
      final storageRef = storage.ref();
      final folderRef = storageRef.child(folderName).child(fileName);
      await folderRef.putFile(File(filePath));
      var downloadLink = await folderRef.getDownloadURL();
      return ApiResponse(
        statusCode: 200,
        result: downloadLink,
      );
    } catch (e) {
      return ApiResponse(statusCode: 400, result: "Unable to upload photo. Please try again later.");
    }
  }


}
