import 'dart:core';

import 'package:flutter_boilerplate_code/src/features/sessions/data/entities/session.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/models/day.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/models/recurrence.dart';

class RequestBodySession {
  ///FIELDS
  String? id;
  String? userId;
  String? title;
  String? duration;

  Recurrence? recurrence; //daily(1) | weekly(5) | monthly(26) | yearly(312)
  int? lessonCount; //ex. if recurrence=weekly the options are only
  // 5 lessons max, monthly: 26 max this input change it to number instead of select
  List<int> lessonCountList = [];

  DateTime? startDate;
  DateTime? endDate;

  List<Day>? lessonDays;
  bool sameTiming = true; //if same timing for all days
  Map<String, String>? sessionTiming;
  String? sessionTimingForAll;
  DateTime? createdAt;
  String? status; //active, closed, inactive

  RequestBodySession({
    this.id,
    this.userId,
    this.title,
    this.duration,
    this.recurrence,
    this.lessonCount,
    this.lessonDays,
    this.sessionTiming,
    this.createdAt,
    this.status,
  });

  //only for update session
  RequestBodySession.fromSession(Session session) {
    id = session.id;
    userId = session.userId;
    title = session.title;
    duration = session.durationHr;
    //recurrence = session.recurrence;
    lessonCount = session.lessonCount;
    //lessonDays = session.lessonDays;
    sameTiming = session.sameTiming??false;
    sessionTiming = session.sessionTiming;
    createdAt = session.createdAt;
    status = session.status;
  }

  String getDaysStringAr(){
    if(lessonDays?.isEmpty??true) return "";
    String daysString = "";
    for(var day in lessonDays!){
      daysString += "${day.ar}, ";
    }

    return daysString;
  }

  @override
  String toString() {
    return 'RequestBodySession{id: $id, userId: $userId, title: $title, duration: $duration, recurrence: $recurrence, lessonCount: $lessonCount, lessonDays: $lessonDays, sameTiming: $sameTiming, sessionTiming: $sessionTiming, createdAt: $createdAt, status: $status}';
  }
}
