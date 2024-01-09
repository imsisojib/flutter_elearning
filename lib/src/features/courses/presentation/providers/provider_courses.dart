import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/dialogtype_enum.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/interfaces/interface_repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course_category.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/requests/requestbody_course.dart';
import 'package:flutter_boilerplate_code/src/features/courses/domain/interface_repository_courses.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:provider/provider.dart';

class ProviderCourses extends ChangeNotifier {
  final IRepositoryCourses repositoryCourses;

  ProviderCourses({
    required this.repositoryCourses,
  });

  //states
  bool _loading = false;
  bool _submitLoading = false;
  RequestBodyCourse? _requestBodyCourse;
  List<Course> _myCourses = [];

  //getters
  bool get loading => _loading;

  bool get submitLoading => _submitLoading;

  RequestBodyCourse? get requestBodyCourse => _requestBodyCourse;

  List<Course> get myCourses => _myCourses;

  //setters
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  set submitLoading(bool flag) {
    _submitLoading = flag;
    notifyListeners();
  }

  set requestBodyCourse(RequestBodyCourse? course) {
    _requestBodyCourse = course;
    notifyListeners();
  }

  //methods
  void startCourseCreate() {
    _requestBodyCourse = RequestBodyCourse();
    //setting teacher id
    _requestBodyCourse?.teacherId =
        Provider.of<ProviderAccount>(sl<NavigationService>().navigatorKey.currentContext!, listen: false)
            .currentUser
            ?.uid;
    notifyListeners();
  }

  void startUpdateCourse(Course course) {
    _requestBodyCourse = RequestBodyCourse.fromCourse(course);
    //setting teacher id
    _requestBodyCourse?.teacherId =
        Provider.of<ProviderAccount>(sl<NavigationService>().navigatorKey.currentContext!, listen: false)
            .currentUser
            ?.uid;
    notifyListeners();
  }

  void createCourse() async {
    if (_requestBodyCourse?.name?.isEmpty ?? true) {
      WidgetHelper.showNotificationToast(
        "Warning!",
        "Course name can't be empty!",
        DialogTypeEnum.warning,
      );
      return;
    }
    if (_requestBodyCourse?.categoryId?.isEmpty ?? true) {
      WidgetHelper.showNotificationToast(
        "Warning!",
        "Please select course category!",
        DialogTypeEnum.warning,
      );
      return;
    }
    if (_requestBodyCourse?.price == null) {
      WidgetHelper.showNotificationToast(
        "Warning!",
        "Price can't be empty!",
        DialogTypeEnum.warning,
      );
      return;
    }

    submitLoading = true;
    var apiResponse = await repositoryCourses.createCourse(_requestBodyCourse!);
    if (apiResponse.statusCode == 200) {
      Navigator.pop(sl<NavigationService>().navigatorKey.currentContext!);
      WidgetHelper.showNotificationToast(
        "Success",
        "Course has created successfully.",
        DialogTypeEnum.success,
      );
      fetchMyCourses(forceFetch: true,);
      _requestBodyCourse = null;  //clear data
    } else if (apiResponse.statusCode == 401) {
      WidgetHelper.showNotificationToast(
        "Unauthorized",
        "Login Required!",
        DialogTypeEnum.failed,
      );
      Provider.of<ProviderAccount>(sl<NavigationService>().navigatorKey.currentContext!, listen: false).logout();
    } else {
      WidgetHelper.showNotificationToast(
        "Failed",
        "Unable to create course.",
        DialogTypeEnum.failed,
      );
    }
    submitLoading = false;
  }

  Future<void> fetchMyCourses({bool forceFetch = false}) async {
    if(_myCourses.isNotEmpty && !forceFetch) return; //no need to fetch if data is already available
    loading = true;
    _myCourses = await repositoryCourses.fetchMyCourses();
    loading = false;
  }

  Future<List<CourseCategory>> getCourseCategories() async{
    return await repositoryCourses.fetchCourseCategories();
  }

  Future<void> deleteCourse(String? id) async {
    if(id==null || id.isEmpty) return;

    //always return 200
    await repositoryCourses.deleteCourse(id);
    fetchMyCourses(forceFetch: true,);


  }

  Future<void> updateCourse() async {
    if (_requestBodyCourse?.name?.isEmpty ?? true) {
      WidgetHelper.showNotificationToast(
        "Warning!",
        "Course name can't be empty!",
        DialogTypeEnum.warning,
      );
      return;
    }

    if (_requestBodyCourse?.price == null) {
      WidgetHelper.showNotificationToast(
        "Warning!",
        "Price can't be empty!",
        DialogTypeEnum.warning,
      );
      return;
    }

    submitLoading = true;
    var apiResponse = await repositoryCourses.updateCourse(_requestBodyCourse!);
    if (apiResponse.statusCode == 200) {
      Navigator.pop(sl<NavigationService>().navigatorKey.currentContext!);
      WidgetHelper.showNotificationToast(
        "Success",
        "Course has updated successfully.",
        DialogTypeEnum.success,
      );
      fetchMyCourses(forceFetch: true);
      _requestBodyCourse = null;  //clear data
    } else if (apiResponse.statusCode == 401) {
      WidgetHelper.showNotificationToast(
        "Unauthorized",
        "Login Required!",
        DialogTypeEnum.failed,
      );
      Provider.of<ProviderAccount>(sl<NavigationService>().navigatorKey.currentContext!, listen: false).logout();
    } else {
      WidgetHelper.showNotificationToast(
        "Failed",
        "Unable to update course.",
        DialogTypeEnum.failed,
      );
    }
    submitLoading = false;
  }
}
