import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/app_Localization.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_model.dart';

class ProviderLanguage extends ChangeNotifier{
  final ICacheRepository cacheRepository;

  ProviderLanguage({required this.cacheRepository,}){
    //whenever ProviderLanguage will be created then locale also be updated.
    _updateLocaleFromCache();
  }

  //states
  Locale _currentLocale = const Locale("en");
  String _currentLocaleName = "English";

  //getters
  Locale get currentLocale => _currentLocale;
  String get currentLocaleName => _currentLocaleName;

  void updateLocaleByCode(String languageCode) async {
    await cacheRepository.saveLocale(languageCode);
    _currentLocale = _locale(languageCode);
    _currentLocaleName = _localeNameByCode(languageCode);
    notifyListeners();
  }

  void _updateLocaleFromCache() async {
    String languageCode = cacheRepository.getLocale();
    _currentLocale = _locale(languageCode);
    _currentLocaleName = _localeNameByCode(languageCode);
    notifyListeners();
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Locale('en', 'US');
      case 'zh':
        return const Locale('zh', 'CN');
      case 'fr':
        return const Locale('fr', 'FR');
      case 'hi':
        return const Locale('hi', 'IN');
      case 'ar':
        return const Locale('ar', 'EG');
      case 'ru':
        return const Locale('ru', 'RU');
      case 'ja':
        return const Locale('ja', 'JP');
      case 'de':
        return const Locale('de', 'DE');
      case 'es':
        return const Locale('es', 'ES');
      default:
        return const Locale('en', 'US');
    }
  }

  String _localeNameByCode(String languageCode) {
    switch (languageCode) {
      case 'en':
        return "English";
      case 'ar':
        return "Arabic";
      default:
        return "";
    }
  }

  List<LanguageModel> languageList(){
    return [
      LanguageModel(name: "Arabic", code: "ar",),
      LanguageModel(name: "English", code: "en",),
    ];
  }

}