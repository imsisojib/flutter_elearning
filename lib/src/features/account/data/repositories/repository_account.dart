import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/constants.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/interfaces/interface_repository_account.dart';

class RepositoryAccount implements IRepositoryAccount {
  final IFirebaseDBInterceptor firebaseInterceptor;
  final FirebaseAuth auth;

  RepositoryAccount({
    required this.firebaseInterceptor,
    required this.auth,
  });

  @override
  void sendOtpCodeToPhone({
    required String phoneNumber,
    Function? onVerificationFailed,
    Function? onCodeSent,
    Function? onError,
  }) {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
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
      return await auth.signInWithCredential(authCredential);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ApiResponse> setupUserInitialProfile({required String name, required String role}) async {
    if (auth.currentUser?.uid == null) {
      return ApiResponse(
        statusCode: 401,
        result: "Unauthorized User!",
      );
    }
    return await firebaseInterceptor.insertDocument(
      collectionName: Constants.tableUsers,
      documentId: auth.currentUser!.uid,
      json: {
        UserModel.keyUid: auth.currentUser?.uid,
        UserModel.keyFullName: name,
        UserModel.keyPhoneNumber: auth.currentUser?.phoneNumber,
        UserModel.keyRole: role,
        UserModel.keyProfilePicture: auth.currentUser?.photoURL,
      },
    );
  }

  @override
  Future<ApiResponse> fetchMyProfile() async {
    if (auth.currentUser?.uid == null) {
      return ApiResponse(
        statusCode: 401,
        result: "Unauthorized User!",
      );
    }
    return fetchUserProfile(auth.currentUser!.uid);
  }

  @override
  Future<ApiResponse> fetchUserProfile(String uid) {
    return firebaseInterceptor.readDocument(
      collectionName: Constants.tableUsers,
      documentId: uid,
    );
  }
}
