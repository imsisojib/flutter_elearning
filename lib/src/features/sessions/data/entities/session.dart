import 'dart:core';

class Session {
  ///FIELDS KEY
  static const String keyId = "id";
  static const String keyUserId = "userId";
  static const String keyTitle = "title";
  static const String keyDuration = "duration";
  static const String keyRecurrence = "recurrence";
  static const String keyLessonCount = "lesson_count";
  static const String keyLessonDays = "lesson_days";
  static const String keySameTiming = "same_timing";
  static const String keySessionTiming = "session_timing";
  static const String keyCreatedAt = "created_at";
  static const String keyStatus = "status";

  ///FIELDS
  String? id;
  String? userId;
  String? title;
  String? duration;

  String? recurrence; //daily(1) | weekly(5) | monthly(26) | yearly(312)
  int? lessonCount; //ex. if recurrence=weekly the options are only
  // 5 lessons max, monthly: 26 max this input change it to number instead of select

  List<String>? lessonDays;
  bool? sameTiming; //if same timing for all days
  Map<String, String>? sessionTiming;
  DateTime? createdAt;
  String? status; //active, closed, inactive

  Session({
    this.id,
    this.userId,
    this.title,
    this.duration,
    this.recurrence,
    this.lessonCount,
    this.lessonDays,
    this.sameTiming,
    this.sessionTiming,
    this.createdAt,
    this.status,
  });

  Session.fromJson(Map<String, Object?> json) {
    id = json[keyId] as String?;
    userId = json[keyUserId] as String?;
    title = json[keyTitle] as String?;
    duration = json[keyDuration] as String?;
    recurrence = json[keyRecurrence] as String?;
    lessonCount = json[keyLessonCount] as int?;
    lessonDays = json[keyLessonDays] as List<String>?;
    sameTiming = json[keySameTiming] as bool?;
    sessionTiming = json[keySessionTiming] as Map<String, String>?;
    createdAt = json[keyCreatedAt] != null ? DateTime.parse("${json[keyCreatedAt]}") : null;
    status = json[keyStatus] as String?;
  }
}
