import 'package:flutter_boilerplate_code/constants.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/entities/session.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/requestbodys/requestbody_session.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/domain/interface_repository_sessions.dart';

class RepositorySessions implements IRepositorySessions{
  final IFirebaseDBInterceptor firebaseInterceptor;

  RepositorySessions({required this.firebaseInterceptor,});

  @override
  Future<ApiResponse> createSession(RequestBodySession body) async{
    if(firebaseInterceptor.getAuth().currentUser?.uid==null){
      //unauthorized
      return ApiResponse(statusCode: 401,);
    }

    String sessionId = firebaseInterceptor.getDocumentId(
      collectionName: Constants.tableSessions,
    );

    List<String> lessonDaysSlug = [];
    for(var day in body.lessonDays!){
      lessonDaysSlug.add(day.slug!);
    }

    return await firebaseInterceptor.insertDocument(
      collectionName: Constants.tableSessions,
      documentId: sessionId,
      json: {
        Session.keyId: sessionId,
        Session.keyUserId: firebaseInterceptor.getAuth().currentUser!.uid,
        Session.keyTitle: body.title,
        Session.keyDuration: body.endDate?.difference(body.startDate!).inHours,
        Session.keySessionTiming: body.sessionTiming,
        Session.keySameTiming: body.sameTiming,
        Session.keyLessonDays: lessonDaysSlug,
        Session.keyLessonCount: body.lessonCount,
        Session.keyRecurrence: body.recurrence?.slug,
        Session.keyCreatedAt: body.createdAt,
        Session.keyStartDate: body.startDate,
        Session.keyEndDate: body.endDate,
        Session.keyStatus: body.status,
      },
    );
  }

}