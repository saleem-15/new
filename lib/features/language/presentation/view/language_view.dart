import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/features/language/presentation/controller/language_controller.dart';
import 'package:nuntium/features/language/presentation/view/widgets/language_list_tile.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: ManagerColors.greyPrimary,
          ),
          title: Text(ManagerStrings.language),
        ),
        body: GetBuilder<LanguageController>(
          builder: (controller) => ListView.builder(
            itemCount: controller.languages.length,
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
            itemBuilder: (context, index) => LanguageListTile(
              language: controller.languages[index],
              isCurrentLocale: controller.isCurrentLocale(controller.languages[index]),
              onPressed: () => controller.onLanguageTilePressed(context, controller.languages[index]),
            ),
          ),
        ),
      ),
    );
  }
}
