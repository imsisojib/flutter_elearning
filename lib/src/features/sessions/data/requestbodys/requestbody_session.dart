import 'dart:core';

import 'package:flutter_boilerplate_code/src/features/sessions/data/entities/session.dart';

class RequestBodySession {
  ///FIELDS
  String? id;
  String? userId;
  String? title;
  String? duration;

  String? recurrence; //daily(1) | weekly(5) | monthly(26) | yearly(312)
  int? lessonCount; //ex. if recurrence=weekly the options are only
  // 5 lessons max, monthly: 26 max this input change it to number instead of select

  List<String>? lessonDays;
  bool sameTiming = false; //if same timing for all days
  Map<String, String>? sessionTiming;
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
    duration = session.duration;
    recurrence = session.recurrence;
    lessonCount = session.lessonCount;
    lessonDays = session.lessonDays;
    sameTiming = session.sameTiming??false;
    sessionTiming = session.sessionTiming;
    createdAt = session.createdAt;
    status = session.status;
  }
}
