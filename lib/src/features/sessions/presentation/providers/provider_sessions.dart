import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/config/config_app.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/enums/enum_course_status.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/models/day.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/models/recurrence.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/requestbodys/requestbody_session.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/domain/interface_repository_sessions.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderSessions extends ChangeNotifier{
  final IRepositorySessions repositorySessions;

  ProviderSessions({required this.repositorySessions,});

  //states
  ELoading? _loading;
  List<Day>? _days;
  List<Recurrence>? _recurrences;
  RequestBodySession? _requestBodySession;

  //getters
  ELoading? get loading => _loading;
  List<Day>? get days => _days;
  List<Recurrence>? get recurrences => _recurrences;
  RequestBodySession? get requestBodySession => _requestBodySession;

  //setters
  set loading(ELoading? flag){
    _loading = flag;
    notifyListeners();
  }
  set requestBodySession(RequestBodySession? session){
    print(session.toString());
    _requestBodySession = session;
    notifyListeners();
  }

  //methods
  void initializeSessionCreation(){
    _requestBodySession = RequestBodySession();
    loadDayNames();
    loadRecurrences();
  }

  void loadDayNames() {
    _days = [];
    sl<ConfigApp>().dayNames().forEach((element) {
      _days!.add(Day.fromJson(element));
    });
    notifyListeners();
  }

  void loadRecurrences() {
    _recurrences = [];
    sl<ConfigApp>().recurrences().forEach((element) {
      _recurrences!.add(Recurrence.fromJson(element));
    });
    notifyListeners();
  }

  void disposeSessionCreation(){
    _days = null;
    _recurrences = null;
    _requestBodySession = null;
  }

  Future<void> createSession() async {
    loading = ELoading.submitLoading;

    _requestBodySession?.createdAt = DateTime.now();
    _requestBodySession?.status = ECourseStatus.pending.name;
    var response = await repositorySessions.createSession(_requestBodySession!);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Session is created.");
      Navigator.pushReplacementNamed(
        sl<NavigationService>().navigatorKey.currentContext!,
        Routes.classInvitationScreen,
      );
    }else{
      Fluttertoast.showToast(msg: "Something is went wrong!");
    }
    loading = null;
  }

}