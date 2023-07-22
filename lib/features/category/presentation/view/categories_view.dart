import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/widgets/screen_header.dart';
import 'package:nuntium/features/category/presentation/controller/categories_controller.dart';

import 'widgets/category_chip.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              right: ManagerWidth.w20,
              left: ManagerWidth.w20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: ManagerStrings.categories,
                  paragraph: ManagerStrings.categoriesParagraph,
                ),
                GetBuilder<CategoriesController>(
                  builder: (_) {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.topics.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ManagerWidth.w16,
                        mainAxisSpacing: ManagerHeight.h36,
                        childAspectRatio: 160 / 72,
                      ),
                      itemBuilder: (_, index) => CategoryChip(
                        topic: controller.topics[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
