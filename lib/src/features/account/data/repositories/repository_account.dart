import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/constants.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/interfaces/interface_repository_account.dart';

class RepositoryAccount implements IRepositoryAccount {
  final IFirebaseDBInterceptor firebaseInterceptor;

  RepositoryAccount({
    required this.firebaseInterceptor,
  });

  @override
  void sendOtpCodeToPhone({
    required String phoneNumber,
    int? resendingToken,
    Function? onVerificationFailed,
    Function? onCodeSent,
    Function? onError,
  }) {
    firebaseInterceptor.getAuth().verifyPhoneNumber(
          phoneNumber: phoneNumber,
          forceResendingToken: resendingToken,  //only android will have value, ios always null
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential authCredential) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
          verificationFailed: (FirebaseAuthException error) {
            onVerificationFailed?.call(error);
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            onCodeSent?.call(verificationId, forceResendingToken);
          },
        );
  }

  @override
  Future<UserCredential?> signInByPhoneByVerifyingOTP({
    required String otpCode,
    required String verificationId,
  }) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );

    try {
      return await firebaseInterceptor.getAuth().signInWithCredential(authCredential);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ApiResponse> setupUserInitialProfile({
    required String firstName,
    required String lastName,
    String? email,
    required String role,
  }) async {
    if (firebaseInterceptor.getAuth().currentUser?.uid == null) {
      return ApiResponse(
        statusCode: 401,
        result: "Unauthorized User!",
      );
    }
    return await firebaseInterceptor.insertDocument(
      collectionName: Constants.tableUsers,
      documentId: firebaseInterceptor.getAuth().currentUser!.uid,
      json: {
        UserModel.keyUid: firebaseInterceptor.getAuth().currentUser?.uid,
        UserModel.keyFirstName: firstName,
        UserModel.keyLastName: lastName,
        UserModel.keyEmail: email,
        UserModel.keyPhoneNumber: firebaseInterceptor.getAuth().currentUser?.phoneNumber,
        UserModel.keyRole: role,
        UserModel.keyProfilePicture: firebaseInterceptor.getAuth().currentUser?.photoURL,
      },
    );
  }

  @override
  Future<ApiResponse> updateMyProfileInfo({required Map<String, dynamic> json}) async {
    if (firebaseInterceptor.getAuth().currentUser?.uid == null) {
      return ApiResponse(
        statusCode: 401,
        result: "Unauthorized User!",
      );
    }
    return await firebaseInterceptor.insertDocument(
      collectionName: Constants.tableUsers,
      documentId: firebaseInterceptor.getAuth().currentUser!.uid,
      mergeData: true, //if false then previous data will be gone
      json: json,
    );
  }

  @override
  Future<ApiResponse> fetchMyProfile() async {
    if (firebaseInterceptor.getAuth().currentUser?.uid == null) {
      return ApiResponse(
        statusCode: 401,
        result: "Unauthorized User!",
      );
    }
    return fetchUserProfile(firebaseInterceptor.getAuth().currentUser!.uid);
  }

  @override
  Future<ApiResponse> fetchUserProfile(String uid) {
    return firebaseInterceptor.readDocument(
      collectionName: Constants.tableUsers,
      documentId: uid,
    );
  }

  @override
  Future<ApiResponse> uploadMyProfilePicture(String path) async {
    if (firebaseInterceptor.getAuth().currentUser?.uid == null) {
      return ApiResponse(
        statusCode: 401,
        result: "Unauthorized User!",
      );
    }
    //first upload profile picture
    //then update users/uid/profile_picture value
    var apiResponse = await firebaseInterceptor.uploadPhoto(
      filePath: path,
      folderName: Constants.storageProfilePictures,
      fileName: firebaseInterceptor.getAuth().currentUser!.uid,
    );

    if (apiResponse.statusCode == 200) {
      //now update the download link to user table
      return await firebaseInterceptor.insertDocument(
        collectionName: Constants.tableUsers,
        documentId: firebaseInterceptor.getAuth().currentUser!.uid,
        json: {
          UserModel.keyProfilePicture: apiResponse.result, //this result has download link
        },
        mergeData: true, //otherwise previous data will be gone
      );
    } else {
      return apiResponse;
    }
  }
}
