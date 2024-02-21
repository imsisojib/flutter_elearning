import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/requestbodys/requestbody_session.dart';

abstract class IRepositorySessions{
  Future<ApiResponse> createSession(RequestBodySession session);
}