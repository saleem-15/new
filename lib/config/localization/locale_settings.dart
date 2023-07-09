import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';

LocaleSettings localeSettings = LocaleSettings();

class LocaleSettings {
  final AppSettingsSharedPreferences _preferences;

  LocaleSettings() : _preferences = instance<AppSettingsSharedPreferences>();

  static const Map<String, String> languages = {
    Constants.arabicKey: Constants.arabic,
    Constants.englishKey: Constants.english
  };

  Future<void> changeLanguage({
    required BuildContext context,
    required String langCode,
  }) async {
    _preferences.setLocale(langCode);
    await EasyLocalization.of(context)!.setLocale(Locale(langCode));
    Get.updateLocale(Locale(langCode));
  }

  Locale currentLocale(BuildContext context) {
    return EasyLocalization.of(context)!.currentLocale!;
  }

  List<Locale> get supportedLocales => languages.keys.map((e) => Locale(e)).toList();

  Locale get defaultLocale => Locale(_preferences.locale);
}
