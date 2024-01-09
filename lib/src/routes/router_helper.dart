import 'package:fluro/fluro.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_initial_profile_setup.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_login.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_more.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_my_profile.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_otp_verfication.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_profile_edit.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/screens/screen_course_add.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/screens/screen_course_update.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/screens/screen_courses.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/screens/screen_select_course_category.dart';
import 'package:flutter_boilerplate_code/src/features/errors/presentation/screens/screen_error.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/screens/screen_home.dart';
import 'package:flutter_boilerplate_code/src/features/progress/presentation/screens/screen_progress.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';


class RouterHelper {
  static final FluroRouter router = FluroRouter();

  ///#region MAIN FLOW
  static final Handler _homeScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenHome();
  });
  static final Handler _coursesScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenCourses();
  });
  static final Handler _progressScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenProgress();
  });
  static final Handler _moreScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenMore();
  });
  //#endregion

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
  static final Handler _profileScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenMyProfile();
  });
  static final Handler _profileEditScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenProfileEdit();
  });

  ///COURSES
  static final Handler _courseAddScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenCourseAdd();
  });
  static final Handler _courseUpdateScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenCourseUpdate();
  });
  static final Handler _courseCategorySelectScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenSelectCourseCategory();
  });


  static final Handler _notFoundHandler =
  Handler(handlerFunc: (context, parameters) => const ScreenError());

  void setupRouter() {
    router.notFoundHandler = _notFoundHandler;

    //main-nav flow
    router.define(Routes.homeScreen, handler: _homeScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.coursesScreen, handler: _coursesScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.progressScreen, handler: _progressScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.moreScreen, handler: _moreScreenHandler, transitionType: TransitionType.fadeIn);

    ///ACCOUNT & AUTH
    router.define(Routes.loginScreen, handler: _loginScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.otpVerificationScreen, handler: _otpVerificationScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.initialProfileSetupScreen, handler: _initialProfileSetupScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.profileScreen, handler: _profileScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.editProfileScreen, handler: _profileEditScreenHandler, transitionType: TransitionType.cupertino);

    ///COURSES
    router.define(Routes.courseAddScreen, handler: _courseAddScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.courseUpdateScreen, handler: _courseUpdateScreenHandler, transitionType: TransitionType.cupertino);
    router.define(Routes.courseCategorySelectScreen, handler: _courseCategorySelectScreenHandler, transitionType: TransitionType.cupertino);

  }

}