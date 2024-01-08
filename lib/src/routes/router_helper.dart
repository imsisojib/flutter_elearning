import 'package:fluro/fluro.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_initial_profile_setup.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_login.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_otp_verfication.dart';
import 'package:flutter_boilerplate_code/src/features/errors/presentation/screens/screen_error.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/screens/screen_home.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';


class RouterHelper {
  static final FluroRouter router = FluroRouter();

  ///Handlers
  static final Handler _homeScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenHome();
  });

  ///ACCOUNT & AUTH
  static final Handler _loginScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenLogin();
  });

  static final Handler _otpVerificationScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenOtpVerification();
  });

  static final Handler _initialProfileSetupScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenInitialProfileSetup();
  });

  static final Handler _notFoundHandler =
  Handler(handlerFunc: (context, parameters) => const ScreenError());

  void setupRouter() {
    router.notFoundHandler = _notFoundHandler;

    //main-nav flow
    router.define(Routes.homeScreen, handler: _homeScreenHandler, transitionType: TransitionType.fadeIn);

    ///ACCOUNT & AUTH
    router.define(Routes.loginScreen, handler: _loginScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.otpVerificationScreen, handler: _otpVerificationScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.initialProfileSetupScreen, handler: _initialProfileSetupScreenHandler, transitionType: TransitionType.cupertino);
  }

}