import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course_category.dart';

class Course{
  //table field names for Firebase
  static const String keyId = "id";
  static const String keyName = "name";
  static const String keyCategoryId = "category_id";
  static const String keyDescription = "description";
  static const String keyPrice = "price";
  static const String keyOfferPrice = "offer_price";
  static const String keyThumbnail = "thumbnail";
  static const String keyTeacherId = "teacher_id";
  static const String keyTotalEnrolled = "total_enrolled";
  static const String keyTotalClass = "total_class";
  static const String keyRating = "rating";
  static const String keyStatus = "status";

  String? id;
  String? name;
  String? categoryId;
  String? description;
  double price = 0;
  double offerPrice = 0;
  String? thumbnail;
  String? teacherId;
  int totalEnrolled = 0;
  int totalClass = 0;
  int rating = 0;
  String? status;   //pending, approved, rejected,

  UserModel? teacher; //local purpose: for showing data,
  CourseCategory? category; //local purpose: for showing data,

  Course();

  Course.fromJson(Map<String, Object?> json){
    id = json[keyId] as String?;
    name = json[keyName] as String?;
    categoryId = json[keyCategoryId] as String?;
    description = json[keyDescription] as String?;
    price = json[keyPrice] as double;
    offerPrice = json[keyOfferPrice] as double;
    thumbnail = json[keyThumbnail] as String?;
    teacherId = json[keyTeacherId] as String?;
    totalEnrolled = json[keyTotalEnrolled] as int;
    totalClass = json[keyTotalClass] as int;
    rating = json[keyRating] as int;
    status = json[keyStatus] as String?;
  }

  @override
  String toString() {
    return 'Course{id: $id, name: $name, categoryId: $categoryId, description: $description, price: $price, offerPrice: $offerPrice, thumbnail: $thumbnail, teacherId: $teacherId, totalEnrolled: $totalEnrolled, totalClass: $totalClass, rating: $rating, teacher: $teacher, category: $category}';
  }
}