import 'package:firebase_auth/firebase_auth.dart';

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
}
