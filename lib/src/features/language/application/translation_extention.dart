import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';

import 'app_Localization.dart';

extension TranslationExtention on String {
  String get tr { //translate on any text
    return AppLocalization.of(sl<NavigationService>().navigatorKey.currentContext!)!.translate(this) ?? this;
  }
}
