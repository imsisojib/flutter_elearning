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
  Future<ApiResponse> createCourse(RequestBodySession body) async{
    String sessionId = firebaseInterceptor.getDocumentId(
      collectionName: Constants.tableSessions,
    );

    return await firebaseInterceptor.insertDocument(
      collectionName: Constants.tableSessions,
      documentId: sessionId,
      json: {
        Session.keyId: sessionId,
        Session.keyUserId: body.userId,
        Session.keyTitle: body.title,
        Session.keyDuration: body.duration,
        Session.keySessionTiming: body.sessionTiming,
        Session.keySameTiming: body.sameTiming,
        Session.keyLessonDays: body.lessonDays,
        Session.keyLessonCount: body.lessonCount,
        Session.keyRecurrence: body.recurrence,
        Session.keyCreatedAt: body.createdAt,
        Session.keyStatus: body.status,
      },
    );
  }

}