import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/my_app.dart';
import 'package:flutter_boilerplate_code/src/core/application/token_service.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/presentation/providers/provider_invitations.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/providers/provider_courses.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/providers/provider_common.dart';
import 'package:flutter_boilerplate_code/src/features/language/presentation/providers/provider_language.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/presentation/providers/provider_sessions.dart';
import 'di_container.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();  //initializing Dependency Injection

  //update auth-token from cache [to check user logged-in or not]
  //var token = di.sl<ICacheRepository>().fetchToken();
  //di.sl<TokenService>().updateToken(token??"");  //update token will re-initialize wherever token was used

  await Firebase.initializeApp();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ProviderCommon>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProviderAccount>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProviderCourses>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProviderLanguage>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProviderInvitations>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProviderSessions>()),
      ],
      child: const MyApp(),
    ),
  );
}
