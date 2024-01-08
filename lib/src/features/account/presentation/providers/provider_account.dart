import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/dialogtype_enum.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/interfaces/interface_repository_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderAccount extends ChangeNotifier {
  final IRepositoryAccount repositoryAccount;

  ProviderAccount({required this.repositoryAccount});

  //states
  bool _loading = false;
  bool _submitLoading = false;
  String? _verficationId;
  UserModel? _currentUser;

  //getters
  bool get loading => _loading;
  bool get submitLoading => _submitLoading;
  UserModel? get currentUser => _currentUser;

  //setters
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  set submitLoading(bool flag) {
    _submitLoading = flag;
    notifyListeners();
  }

  set currentUser(UserModel? model){
    _currentUser = model;
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
      //now check this user data already exists or not,
      //if exists just navigate to home otherwise go to initial profile setup page
      var profileData = await repositoryAccount.fetchMyProfile();
      if(profileData.statusCode!=200){
        //means data not found
        Fluttertoast.showToast(msg: "Sign in successful.");
        Navigator.pushNamedAndRemoveUntil(
          sl<NavigationService>().navigatorKey.currentContext!,
          Routes.initialProfileSetupScreen,
              (route) => false,
        );
      }else{
        Fluttertoast.showToast(msg: "Sign in successful.");
        Navigator.pushNamedAndRemoveUntil(
          sl<NavigationService>().navigatorKey.currentContext!,
          Routes.homeScreen,
              (route) => false,
        );
      }
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

  void fetchMyProfile({bool forceUpdate = false}) async{
    if(_currentUser!=null && !forceUpdate) return;  //no need to fetch data if already data available
    loading = true;
    ApiResponse response = await repositoryAccount.fetchMyProfile();
    if(response.statusCode==200){
      _currentUser = UserModel.fromJson(response.result,);
    }else if(response.statusCode==401){
      //login required
    }
    _currentUser.toString();

    loading = false;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      sl<NavigationService>().navigatorKey.currentContext!,
      Routes.loginScreen,
          (route) => false,
    );
  }

  void updateMyProfilePicture(String path) async{
    submitLoading = true;
    var apiResponse = await repositoryAccount.uploadMyProfilePicture(path);
    if(apiResponse.statusCode==200){
      WidgetHelper.showNotificationToast("Successful!", "Profile picture is updated successfully!", DialogTypeEnum.success,);
      fetchMyProfile(forceUpdate: true,);
    }else if(apiResponse.statusCode==401){
      WidgetHelper.showNotificationToast("Failed!", "Login required!", DialogTypeEnum.failed,);
      logout();
    }else{
      WidgetHelper.showNotificationToast("Failed!", apiResponse.result, DialogTypeEnum.failed,);
    }
    submitLoading = false;
  }

  void updateMyProfileInfo() async{
    if(currentUser?.fullName?.isEmpty??true){
      Fluttertoast.showToast(msg: "Name can't be empty!",);
      return;
    }

    submitLoading = true;

    var response = await repositoryAccount.updateMyProfileInfo(
      json: {
        UserModel.keyFullName : _currentUser?.fullName,
        UserModel.keyCountry : _currentUser?.country,
        UserModel.keyBirthdate : _currentUser?.birthdate,
      }
    );

    if(response.statusCode==200){
      //profile updated
      Fluttertoast.showToast(msg: response.result,);
      fetchMyProfile(forceUpdate: true,);

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

    submitLoading = false;

  }

}
