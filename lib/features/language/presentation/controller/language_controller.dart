import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/localization/locale_settings.dart';
import 'package:nuntium/features/language/model/language.dart';

class LanguageController extends GetxController {
  Locale get currentLocale => localeSettings.currentLocale(Get.context!);

  List<Language> languages = [];

  @override
  void onInit() {
    super.onInit();
    initLanguageList();
  }

  void initLanguageList() {
    const supportedLanguages = LocaleSettings.languages;

    supportedLanguages.forEach((key, value) {
      languages.add(
        Language(
          langCode: key,
          name: value,
        ),
      );
    });
  }

  onLanguageTilePressed(BuildContext context, Language languag) async {
    await localeSettings.changeLanguage(
      context: context,
      langCode: languag.langCode,
    );
    update();
  }

  bool isCurrentLocale(Language language) {
    return currentLocale.languageCode == language.langCode;
  }
}
