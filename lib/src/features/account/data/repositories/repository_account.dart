import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
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
  }) async{
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationId ,
      smsCode: otpCode,
    );

    try {
      return await auth.signInWithCredential(authCredential);
    } catch (e) {
      return null;
    }
  }
}
