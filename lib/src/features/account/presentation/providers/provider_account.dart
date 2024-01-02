import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderAccount extends ChangeNotifier {
  //states
  bool _loading = false;
  String? _verficationId;

  //getters
  bool get loading => _loading;

  //setters
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  //methods
  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser?.uid != null;
  }

  void sentOtpCode({required String phoneNumber}) {
    loading = true;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationFailed: (FirebaseAuthException error) {
        Fluttertoast.showToast(msg: "Unable to sent verification code. Please try again later.");
        Debugger.debug(
          title: "ProviderAccount.sentOtpCode(): verification failed",
          data: error.message,
        );
        loading = false;
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _verficationId = verificationId;
        Fluttertoast.showToast(msg: "Verification code is sent to your phone number!");
        Navigator.pushNamed(
          sl<NavigationService>().navigatorKey.currentContext!,
          Routes.otpVerificationScreen,
        );
        loading = false;
      },
    );
    //loading = false;
  }

  Future<void> signInWithPhoneNumber({required String otpCode}) async {
    loading = true;
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: _verficationId ?? "",
      smsCode: otpCode,
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
      Fluttertoast.showToast(msg: "Sign in successful.");
      Navigator.pushNamedAndRemoveUntil(
        sl<NavigationService>().navigatorKey.currentContext!,
        Routes.homeScreen,
        (route) => false,
      );
    } catch (e) {
      print("Sign In Failed: $e");
    }

    loading = false;
  }
}
