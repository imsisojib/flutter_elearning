import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course_category.dart';

class RequestBodyCourse {
  String? id; //only for update course
  String? name;
  String? categoryId;
  String? categoryName;
  String? description;
  double price = 0;
  double offerPrice = 0;
  String? thumbnailPath; //device file's storage path
  String? teacherId;
  int totalEnrolled = 0;
  int totalClass = 0;
  int rating = 0;

  RequestBodyCourse({
    this.price = 0,
    this.offerPrice = 0,
  });

  RequestBodyCourse.fromCourse(Course course){
    id = course.id;
    teacherId = course.teacherId;
    name = course.name;
    categoryId = course.categoryId;
    description = course.description;
    price = course.price;
    offerPrice = course.offerPrice;
    totalClass = course.totalClass;
    thumbnailPath = course.thumbnail;
  }

}
