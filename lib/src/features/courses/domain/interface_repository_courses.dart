import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course_category.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/requests/requestbody_course.dart';

abstract class IRepositoryCourses{
  Future<List<Course>> fetchMyCourses();
  Future<ApiResponse> createCourse(RequestBodyCourse course);

  Future<List<CourseCategory>> fetchCourseCategories();
}