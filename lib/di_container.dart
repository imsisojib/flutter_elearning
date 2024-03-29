import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_boilerplate_code/src/config/config_api.dart';
import 'package:flutter_boilerplate_code/src/core/application/api_interceptor.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/application/token_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/repositories/cache_repository_impl.dart';
import 'package:flutter_boilerplate_code/src/core/data/repositories/firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_api_interceptor.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/repositories/repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/interfaces/interface_repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/repositories/repository_courses.dart';
import 'package:flutter_boilerplate_code/src/features/courses/domain/interface_repository_courses.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/providers/provider_courses.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/providers/provider_common.dart';
import 'package:flutter_boilerplate_code/src/features/language/presentation/providers/provider_language.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //using dependency-injection
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  ///REPOSITORIES
  //#region Repositories
  sl.registerLazySingleton<ICacheRepository>(
    () => CacheRepositoryImpl(
      sharedPreference: sl(),
    ),
  );
  sl.registerLazySingleton<IRepositoryAccount>(
    () => RepositoryAccount(
      firebaseInterceptor: sl(),
    ),
  );
  sl.registerLazySingleton<IRepositoryCourses>(
    () => RepositoryCourses(
      firebaseInterceptor: sl(),
    ),
  );
  //#endregion

  ///USE-CASES

  ///END of USE-CASES

  ///PROVIDERS
  //region Providers
  sl.registerFactory(() => ProviderCommon());
  sl.registerFactory(() => ProviderAccount(repositoryAccount: sl()));
  sl.registerFactory(() => ProviderCourses(repositoryCourses: sl()));
  sl.registerFactory(() => ProviderLanguage(cacheRepository: sl()));

  ///Interceptors
  sl.registerLazySingleton<IFirebaseDBInterceptor>(
    () => FirebaseDBInterceptor(
      db: sl(),
      storage: sl(),
      auth: sl(),
    ),
  );
  sl.registerLazySingleton<IApiInterceptor>(
    () => ApiInterceptor(
      baseUrl: ConfigApi.baseUrl,
    ),
  );

  ///CHANGE SERVER HERE

  ///services
  sl.registerSingleton(NavigationService()); //to initialize navigator-key for app-runtime
  sl.registerSingleton(TokenService()); //token service to store token app-runtime
  //logger
  sl.registerLazySingleton(
    () => Logger(
      printer: PrettyPrinter(
        colors: false,
      ),
    ),
  );
}
