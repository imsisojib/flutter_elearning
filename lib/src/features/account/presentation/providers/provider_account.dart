import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/interfaces/interface_repository_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderAccount extends ChangeNotifier {
  final IRepositoryAccount repositoryAccount;

  ProviderAccount({required this.repositoryAccount});

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
    repositoryAccount.sendOtpCodeToPhone(
      phoneNumber: phoneNumber,
      onVerificationFailed: (FirebaseAuthException error) {
        Fluttertoast.showToast(msg: "Unable to sent verification code. Please try again later.");
        Debugger.debug(
          title: "ProviderAccount.sentOtpCode(): verification failed",
          data: error.message,
        );
        loading = false;
      },
      onCodeSent: (String verificationId, int? forceResendingToken) {
        _verficationId = verificationId;
        Fluttertoast.showToast(msg: "Verification code is sent to your phone number!");
        Navigator.pushNamed(
          sl<NavigationService>().navigatorKey.currentContext!,
          Routes.otpVerificationScreen,
        );
        loading = false;
      },
      onError: (){

      }
    );
    //loading = false;
  }

  Future<void> signInWithPhoneNumber({required String otpCode}) async {
    loading = true;
    UserCredential? userCredential = await repositoryAccount.signInByPhoneByVerifyingOTP(otpCode: otpCode, verificationId: _verficationId??"");
    if(userCredential?.user!=null){
      Fluttertoast.showToast(msg: "Sign in successful.");
      Navigator.pushNamedAndRemoveUntil(
        sl<NavigationService>().navigatorKey.currentContext!,
        Routes.initialProfileSetupScreen,
            (route) => false,
      );
    }else{
      Fluttertoast.showToast(msg: "Unable verify OTP code!");
    }
    loading = false;
  }

  void setupInitialProfile({String? name, String? role}) async{
    if(name?.isEmpty??true){
      Fluttertoast.showToast(msg: "Name can't be empty!",);
      return;
    }
    if(role?.isEmpty??true){
      Fluttertoast.showToast(msg: "Please select your joining type!",);
      return;
    }

    loading = true;

    var response = await repositoryAccount.setupUserInitialProfile(
      name: name!,
      role: role!,
    );

    if(response.statusCode==200){
      //profile updated
      Fluttertoast.showToast(msg: response.result,);
      Navigator.pushNamedAndRemoveUntil(
        sl<NavigationService>().navigatorKey.currentContext!,
        Routes.homeScreen,
            (route) => false,
      );
    }else if(response.statusCode==401){
      Fluttertoast.showToast(msg: response.result,);
      Navigator.pushNamedAndRemoveUntil(
        sl<NavigationService>().navigatorKey.currentContext!,
        Routes.loginScreen,
            (route) => false,
      );
    }else{
      Fluttertoast.showToast(msg: response.result,);
    }

    loading = false;

  }
}
