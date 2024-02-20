class ConfigApp {
  List<Map<String, dynamic>> dayNames() {
    return [
      {"slug": "sunday", "en": "Sunday", "ar": "الأحد"},
      {"slug": "monday", "en": "Monday", "ar": "الاثنين"},
      {"slug": "tuesday", "en": "Tuesday", "ar": "الثلاثاء"},
      {"slug": "wednesday", "en": "Wednesday", "ar": "الأربعاء"},
      {"slug": "thursday", "en": "Thursday", "ar": "الخميس"},
      {"slug": "friday", "en": "Friday", "ar": "الجمعة"},
      {"slug": "saturday", "en": "Saturday", "ar": "السبت"},
    ];
  }

  List<Map<String,dynamic>> recurrences() {
    return [
      {"slug": "daily", "en": "Daily", "ar": "يوميًا", "value": 1,},
      {"slug": "weekly", "en": "Weekly", "ar": "أسبوعي", "value": 5,},
      {"slug": "monthly", "en": "Monthly", "ar": "شهريا", "value": 26,},
      {"slug": "yearly", "en": "Yearly", "ar": "سنوي", "value": 312,},
    ];
  }
}
