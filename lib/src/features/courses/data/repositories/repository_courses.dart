import 'package:flutter_boilerplate_code/constants.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course_category.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/requests/requestbody_course.dart';
import 'package:flutter_boilerplate_code/src/features/courses/domain/interface_repository_courses.dart';

class RepositoryCourses implements IRepositoryCourses {
  final IFirebaseDBInterceptor firebaseInterceptor;

  RepositoryCourses({
    required this.firebaseInterceptor,
  });

  @override
  Future<ApiResponse> createCourse(RequestBodyCourse course) async {
    String courseId = firebaseInterceptor.getDocumentId(
      collectionName: Constants.tableCourses,
    );

    //upload photo first
    String? thumbnailLink;
    if (course.thumbnailPath?.isNotEmpty ?? false) {
      var photoUploadResponse = await firebaseInterceptor.uploadPhoto(
        filePath: course.thumbnailPath!,
        folderName: Constants.storageCourseThumbs,
        fileName: courseId,
      );
      if(photoUploadResponse.statusCode==200){
        thumbnailLink = photoUploadResponse.result;
      }
    }

    return await firebaseInterceptor.insertDocument(
      collectionName: Constants.tableCourses,
      documentId: courseId,
      json: {
        Course.keyId: courseId,
        Course.keyTeacherId: course.teacherId,
        Course.keyCategoryId: course.categoryId,
        Course.keyName: course.name,
        Course.keyDescription: course.description,
        Course.keyPrice: course.price,
        Course.keyOfferPrice: course.offerPrice,
        Course.keyThumbnail: thumbnailLink,
        Course.keyTotalEnrolled: course.totalEnrolled,
        Course.keyTotalClass: course.totalClass,
        Course.keyRating: course.rating,
      },
    );
  }

  @override
  Future<ApiResponse> fetchMyCourses() {
    // TODO: implement fetchMyCourses
    throw UnimplementedError();
  }

  @override
  Future<List<CourseCategory>> fetchCourseCategories() async {
    List<CourseCategory> categories = [];
    var apiResponse = await firebaseInterceptor.readCollection(collectionName: Constants.tableCourseCategories,);
    if(apiResponse.statusCode==200){
      apiResponse.result.forEach((v) {
        categories.add(CourseCategory.fromJson(v.data()));
      });
    }

    return categories;
  }
}
