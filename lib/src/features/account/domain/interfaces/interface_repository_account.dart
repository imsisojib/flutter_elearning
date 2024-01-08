import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';

abstract class IRepositoryAccount {
  void sendOtpCodeToPhone({
    required String phoneNumber,
    Function? onVerificationFailed,
    Function? onCodeSent,
    Function? onError,
  });

  Future<UserCredential?> signInByPhoneByVerifyingOTP({
    required String otpCode,
    required String verificationId,
  });

  Future<ApiResponse> setupUserInitialProfile({
    required String name,
    required String role,
  });

  Future<ApiResponse> updateMyProfileInfo({required Map<String, dynamic> json});

  Future<ApiResponse> fetchMyProfile();

  Future<ApiResponse> fetchUserProfile(String uid);

  Future<ApiResponse> uploadMyProfilePicture(String path);
}
