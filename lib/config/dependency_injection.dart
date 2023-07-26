import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nuntium/core/internet_checker/internet_checker.dart';
import 'package:nuntium/core/network/app_api.dart';
import 'package:nuntium/core/network/dio_factory.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import 'package:nuntium/core/storage/local/hive_db.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';
import 'package:nuntium/features/article/presentation/controller/article_controller.dart';
import 'package:nuntium/features/auth/data/data_source/remote_login_data_source.dart';
import 'package:nuntium/features/auth/data/data_source/remote_login_with_google_data_source.dart';
import 'package:nuntium/features/auth/data/data_source/remote_register_data_source.dart';
import 'package:nuntium/features/auth/data/repository/login_repository.dart';
import 'package:nuntium/features/auth/data/repository/register_repository.dart';
import 'package:nuntium/features/auth/domain/use_case/login_use_case.dart';
import 'package:nuntium/features/auth/domain/use_case/login_with_google_use_case.dart';
import 'package:nuntium/features/auth/domain/use_case/register_use_case.dart';
import 'package:nuntium/features/auth/presentation/controller/login_controller.dart';
import 'package:nuntium/features/auth/presentation/controller/register_controller.dart';
import 'package:nuntium/features/bookmarks/data/data_source/local_bookmarks_data_source.dart';
import 'package:nuntium/features/bookmarks/data/repository/bookmarks_repository.dart';
import 'package:nuntium/features/bookmarks/domain/use_case/delete_bookmark_use_case.dart';
import 'package:nuntium/features/bookmarks/domain/use_case/get_bookmark_use_case.dart';
import 'package:nuntium/features/bookmarks/presentation/controller/bookmarks_controller.dart';
import 'package:nuntium/features/category/presentation/controller/categories_controller.dart';
import 'package:nuntium/features/category/data/data_source/local_favorite_topic_data_source.dart';
import 'package:nuntium/features/category/data/data_source/remote_topics_data_source.dart';
import 'package:nuntium/features/category/data/repository/favorite_topic_repository.dart';
import 'package:nuntium/features/category/data/repository/topics_repository.dart';
import 'package:nuntium/features/category/domain/use_case/select_favorite_topic_use_case.dart';
import 'package:nuntium/features/category/domain/use_case/topics_use_case.dart';
import 'package:nuntium/features/category/presentation/controller/select_favorite_topic_controller.dart';
import 'package:nuntium/features/change_password/data/data_source/remote_change_password_data_source.dart';
import 'package:nuntium/features/change_password/data/repository/change_password_repository.dart';
import 'package:nuntium/features/change_password/domain/use_case/change_password_use_case.dart';
import 'package:nuntium/features/change_password/presentation/controller/change_password_controller.dart';
import 'package:nuntium/features/forget_password/data/data_source/remote_forget_password_data_source.dart';
import 'package:nuntium/features/forget_password/data/repository/forget_password_repository.dart';
import 'package:nuntium/features/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:nuntium/features/forget_password/presentation/controller/forget_password_controller.dart';
import 'package:nuntium/features/forget_password/presentation/controller/verification_controller.dart';
import 'package:nuntium/features/home/data/data_source/remote_home_data_source.dart';
import 'package:nuntium/features/home/data/repository/home_repository.dart';
import 'package:nuntium/features/home/domain/use_case/home_use_case.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';
import 'package:nuntium/features/language/presentation/controller/language_controller.dart';
import 'package:nuntium/features/main/presentation/controller/main_controller.dart';
import 'package:nuntium/features/out_boarding/presentaion/controller/out_boarding_controller.dart';
import 'package:nuntium/features/out_boarding/presentaion/controller/welcome_controller.dart';
import 'package:nuntium/features/profile/presentation/controller/profile_controller.dart';
import 'package:nuntium/features/terms_and_conditions/presentation/controller/terms_and_conditions_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/data_source/remote_logout_data_source.dart';
import '../features/auth/data/repository/logout_repository.dart';
import '../features/auth/domain/use_case/logout_use_case.dart';
import '../features/splash/controller/splash_controller.dart';

final getIt = GetIt.instance;

initModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  final sharedPreferences = await SharedPreferences.getInstance();

  // initialize local db (hive) and register custom adapters
  await MyHive.init(registerAdapters: (hive) {
    hive.registerAdapter(ArticleAdapter());
  });

  getIt.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  getIt.registerLazySingleton<AppSettingsSharedPreferences>(
    () => AppSettingsSharedPreferences(getIt()),
  );

  //why ? you dont use generic type in bellow!
  getIt.registerLazySingleton(() => DioFactory());

  Dio dio = await getIt<DioFactory>().getDio();

  // what are classes you register in getIt from all the classes in the app
  getIt.registerLazySingleton<AppApi>(
    () => AppApi(dio),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionCheckerPlus()),
  );
}

initSplash() {
  Get.put(SplashController());
}

disposeSplash() {
  Get.delete<SplashController>();
}

initOutBoarding() {
  disposeSplash();
  Get.put(OutBoardingController());
}

disposeOutBoarding() {
  Get.delete<OutBoardingController>();
}

initMainModule() {
  disposeSplash();
  disposeWelcome();
  Get.put(MainController());
  initHome();
  initCategoreisModule();
  initBookmarksModule();
  initProfileModule();
}

initHome() {
  disposeWelcome();

  getIt.safeRegisterLazySingleton<RemoteHomeDataSource>(
    RemoteHomeDataSourceImpl(getIt<AppApi>()),
  );

  getIt.safeRegisterLazySingleton<HomeRepository>(
    HomeRepositoryImpl(
      getIt<RemoteHomeDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.safeRegisterLazySingleton<HomeUseCase>(
    HomeUseCase(getIt<HomeRepository>()),
  );

  Get.put(HomeController());
}

disposeHome() {
  log(
    'disposeHome !!',
    stackTrace: StackTrace.current,
    name: 'Dependency Injection',
  );

  getIt
    ..safeUnRegisterLazySingleton<RemoteHomeDataSource>()
    ..safeUnRegisterLazySingleton<HomeRepository>()
    ..safeUnRegisterLazySingleton<HomeUseCase>();

  Get.delete<HomeController>();
}

initWelcome() {
  disposeOutBoarding();
  Get.put(WelcomeController());
}

initWelcomeModule() {
  getIt.safeRegisterLazySingleton<RemoteLoginDataSource>(
    RemoteLoginDataSourceImpl(),
  );
}

disposeWelcome() {
  disposeOutBoarding();
  Get.delete<WelcomeController>();
}

initLoginModule() {
  disposeSplash();
  disposeOutBoarding();
  disposeWelcome();
  // initVerificationModule();
  // initFcmToken();
  getIt.safeRegisterLazySingleton<RemoteLoginDataSource>(
    RemoteLoginDataSourceImpl(),
  );

  getIt.safeRegisterLazySingleton<RemoteLoginWithGoogleDataSource>(
    RemoteLoginWithGoogleDataSourceImpl(),
  );

  getIt.safeRegisterLazySingleton<LoginRepository>(
    LoginRepositoryImplement(
      getIt<RemoteLoginDataSource>(),
      getIt<RemoteLoginWithGoogleDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.safeRegisterLazySingleton<LoginUseCase>(
    LoginUseCase(
      getIt<LoginRepository>(),
    ),
  );

  getIt.safeRegisterLazySingleton<LoginWithGoogleUseCase>(
    LoginWithGoogleUseCase(
      getIt<LoginRepository>(),
    ),
  );

  Get.put(LoginController());
}

disposeLoginModule() {
  // disposeFcmToken();

  getIt
    ..safeUnRegisterLazySingleton<RemoteLoginDataSource>()
    ..safeUnRegisterLazySingleton<LoginRepository>()
    ..safeUnRegisterLazySingleton<LoginUseCase>();

  Get.delete<LoginController>();
}

initRegisterModule() {
  disposeLoginModule();

  getIt.safeRegisterLazySingleton<RemoteRegisterDataSource>(
    RemoteRegisterDataSourceImpl(),
  );

  getIt.safeRegisterLazySingleton<RegisterRepository>(
    RegisterRepositoryImpl(
      getIt<RemoteRegisterDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.safeRegisterLazySingleton<RegisterUseCase>(
    RegisterUseCase(
      getIt<RegisterRepository>(),
    ),
  );

  Get.put(RegisterController());
}

disposeRegisterModule() {
  getIt
    ..safeUnRegisterLazySingleton<RemoteRegisterDataSource>()
    ..safeUnRegisterLazySingleton<RegisterRepository>()
    ..safeUnRegisterLazySingleton<RegisterUseCase>();

  Get.delete<RegisterController>();
}

initForgetPassword() async {
  disposeLoginModule();

  getIt.safeRegisterLazySingleton<RemoteForgetPasswordDataSource>(
    RemoteForgetPasswordDataSourceImplement(),
  );
  getIt.safeRegisterLazySingleton<ForgetPasswordRepository>(
    ForgetPasswordRepositoryImplement(
      getIt<RemoteForgetPasswordDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );
  getIt.safeRegisterLazySingleton<ForgetPasswordUseCase>(
    ForgetPasswordUseCase(
      getIt<ForgetPasswordRepository>(),
    ),
  );

  Get.put(ForgetPasswordController());
}

disposeForgetPassword() async {
  getIt
    ..safeUnRegisterLazySingleton<RemoteForgetPasswordDataSource>()
    ..safeUnRegisterLazySingleton<ForgetPasswordRepository>()
    ..safeUnRegisterLazySingleton<ForgetPasswordUseCase>();

  Get.delete<ForgetPasswordController>();
}

initVerificationModule() {
  // initSendOtp();

  // if (!GetIt.I.isRegistered<RemoteVerificationDataSource>()) {
  //   instance.registerLazySingleton<RemoteVerificationDataSource>(
  //     () => RemoteVerificationDataSourceImplementation(
  //       instance<AppApi>(),
  //     ),
  //   );
  // }
  //
  // if (!GetIt.I.isRegistered<VerificationRepository>()) {
  //   instance.registerLazySingleton<VerificationRepository>(
  //     () => VerificationRepositoryImpl(
  //       instance<NetworkInfo>(),
  //       instance<RemoteVerificationDataSource>(),
  //     ),
  //   );
  // }
  //
  // if (!GetIt.I.isRegistered<VerificationUseCase>()) {
  //   instance.registerLazySingleton<VerificationUseCase>(
  //     () => VerificationUseCase(
  //       instance<VerificationRepository>(),
  //     ),
  //   );
  // }

  Get.put<VerificationController>(VerificationController());
}

initSelectFavouriteModule() {
  getIt.safeRegisterLazySingleton<LocalFavoriteTopicDataSource>(
    LocalFavoriteTopicDataSourceImplement(),
  );

  getIt.safeRegisterLazySingleton<FavoriteTopicRepository>(
    FavoriteTopicRepositoryImplement(
      getIt<LocalFavoriteTopicDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );
  getIt.safeRegisterLazySingleton(
    SelectFavoriteTopicUseCase(getIt<FavoriteTopicRepository>()),
  );

  getIt.safeRegisterLazySingleton<RemoteTopicsDataSource>(
    RemoteTopicsDataSourceImplement(),
  );

  getIt.safeRegisterLazySingleton<TopicsRepository>(
    TopicsRepositoryImplement(
      getIt<RemoteTopicsDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.safeRegisterLazySingleton(
    TopicsUseCase(getIt<TopicsRepository>()),
  );

  Get.put(SelectFavoriteTopicController());
}

initCategoreisModule() {
  getIt.safeRegisterLazySingleton<RemoteTopicsDataSource>(
    RemoteTopicsDataSourceImplement(),
  );

  getIt.safeRegisterLazySingleton<TopicsRepository>(
    TopicsRepositoryImplement(
      getIt<RemoteTopicsDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.safeRegisterLazySingleton(
    TopicsUseCase(getIt<TopicsRepository>()),
  );
  Get.put(CategoriesController());
}

initBookmarksModule() {
  getIt.safeRegisterLazySingleton<LocalBookmarksDataSource>(
    LocalBookmarksDataSourceImpl(),
  );

  getIt.safeRegisterLazySingleton<BookmarksRepository>(
    BookmarksRepositoryImplement(
      getIt<LocalBookmarksDataSource>(),
    ),
  );

  getIt.safeRegisterLazySingleton(
    ViewBookmarksUseCase(getIt<BookmarksRepository>()),
  );

  getIt.safeRegisterLazySingleton(
    DeleteBookmarkUseCase(getIt<BookmarksRepository>()),
  );

  Get.put(BookmarksController());
}

disposeBookmarksModule() {
  getIt
    ..safeUnRegisterLazySingleton<LocalBookmarksDataSource>()
    ..safeUnRegisterLazySingleton<BookmarksRepository>()
    ..safeUnRegisterLazySingleton<ViewBookmarksUseCase>();

  Get.delete<BookmarksController>();
}

disposeSelectFavouriteModule() {
  Get.delete<SelectFavoriteTopicController>();
}

initTermsAndConditionsModule() {
  Get.put(TermsAndConditionsController());
}

disposeTermsAndConditionsModule() {
  Get.delete<TermsAndConditionsController>();
}

initChangePassword() {
  getIt.safeRegisterLazySingleton<RemoteChangePasswordDataSource>(
    RemoteChangePasswordDataSourceImpl(
      getIt<AppSettingsSharedPreferences>(),
    ),
  );

  getIt.safeRegisterLazySingleton<ChangePasswordRepository>(
    ChangePasswordRepositoryImpl(
      getIt<RemoteChangePasswordDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );

  getIt.safeRegisterLazySingleton(
    ChangePasswordUseCase(getIt<ChangePasswordRepository>()),
  );
  Get.put(ChangePasswordController());
}

disposeChangePassword() {
  getIt
    ..safeUnRegisterLazySingleton<RemoteChangePasswordDataSource>()
    ..safeUnRegisterLazySingleton<ChangePasswordRepository>()
    ..safeUnRegisterLazySingleton<ChangePasswordUseCase>();

  Get.delete<ChangePasswordController>();
}

initLanguageModule() {
  Get.put(LanguageController());
}

disposeLanguageModule() {
  Get.delete<LanguageController>();
}

initArticleModule() {
  Get.put(ArticleController());
}

disposeArticleModule() {
  Get.delete<ArticleController>();
}

initProfileModule() {
  getIt.safeRegisterLazySingleton<RemoteLogoutDataSource>(
    RemoteLogoutDataSourceImpl(),
  );

  getIt.safeRegisterLazySingleton<LogoutRepository>(
    LogoutRepositoryImpl(
      getIt<RemoteLogoutDataSource>(),
      getIt<NetworkInfo>(),
    ),
  );
  getIt.safeRegisterLazySingleton(
    LogoutUseCase(getIt<LogoutRepository>()),
  );

  Get.put(ProfileController());
}

disposeProfileModule() {
  Get.delete<ProfileController>();
}

extension SafeDependencyInjection on GetIt {
  void safeRegisterLazySingleton<T extends Object>(T dependency) {
    if (!isRegistered<T>()) {
      registerLazySingleton<T>(() => dependency);
    } else {
      log(
        '(${dependency.runtimeType}) is Already registered !!',
        // '\n${StackTrace.current.toString()}',
        stackTrace: StackTrace.current,

        name: 'Dependency Injection',
      );
    }
  }

  void safeUnRegisterLazySingleton<T extends Object>() {
    if (isRegistered<T>()) {
      unregister<T>();
    } else {
      log(
        '($T) is Not registered !!',
        // '\n${StackTrace.current.toString()}',
        stackTrace: StackTrace.current,

        name: 'Dependency Injection',
      );
    }
  }
}
