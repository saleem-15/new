import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart' hide TextDirection;
import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';

LocaleSettings localeSettings = LocaleSettings();

class LocaleSettings {
  LocaleSettings() : _preferences = getIt<AppSettingsSharedPreferences>();

  final AppSettingsSharedPreferences _preferences;
  TextDirection get textDirection {
    return currentLocale().languageCode == Constants.arabicKey ? TextDirection.rtl : TextDirection.ltr;
  }

  static const Map<String, String> languages = {
    Constants.arabicKey: Constants.arabic,
    Constants.englishKey: Constants.english
  };

  List<Locale> get supportedLocales => languages.keys.map((e) => Locale(e)).toList();

  Locale get defaultLocale => Locale(_preferences.locale);

  Locale currentLocale() {
    return Locale(_preferences.locale);
  }

  Future<void> changeLanguage({
    required BuildContext context,
    required String langCode,
  }) async {
    _preferences.setLocale(langCode);
    await EasyLocalization.of(context)!.setLocale(Locale(langCode));
    Get.updateLocale(Locale(langCode));
  }
}
