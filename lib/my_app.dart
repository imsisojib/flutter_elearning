import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/app_Localization.dart';
import 'package:flutter_boilerplate_code/src/features/language/presentation/providers/provider_language.dart';
import 'package:flutter_boilerplate_code/src/resources/app_themes.dart';
import 'package:flutter_boilerplate_code/src/routes/router_helper.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'di_container.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NavigationService navigationService = sl();

  @override
  void initState() {
    super.initState();
    RouterHelper().setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, app) {
        return Consumer<ProviderLanguage>(builder: (_,providerLanguage, child){
          return MaterialApp(
            navigatorKey: navigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            locale: providerLanguage.currentLocale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('zh', 'CN'),
              Locale('es', 'ES'),
              Locale('hi', 'IN'),
              Locale('fr', 'FR'),
              Locale('ar', 'EG'), //egypt arabic
              Locale('ru', 'RU'),
              Locale('ja', 'JP'),
              Locale('de', 'DE'),
            ],
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            builder: (context, child) {
              return OverlaySupport.global(
                child: ScrollConfiguration(
                  //Removes the whole app's scroll glow
                  behavior: AppBehavior(),
                  child: child!,
                ),
              );
            },
            title: 'eLearning',
            themeMode: ThemeMode.light,
            theme: buildLightTheme(context),
            initialRoute: Provider.of<ProviderAccount>(context, listen: false).isUserLoggedIn()
                ? Routes.homeScreen
                : Routes.loginScreen,
            //initialRoute: Routes.initialProfileSetupScreen,
            onGenerateRoute: RouterHelper.router.generator,
          );
        });
      },
    );
  }
}

//to avoid scroll glow in whole app
class AppBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
