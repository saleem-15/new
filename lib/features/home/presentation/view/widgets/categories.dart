import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';

import 'category_chip.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      id: GetBuilderIDs.categories_list,
      builder: (controller) {
        return SizedBox(
          height: ManagerHeight.h34,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: ManagerWidth.w20,
            ),
            itemCount: controller.categories.length,
            separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w16),
            itemBuilder: (_, index) {
              final category = controller.categories[index];

              return CategoryChip(
                text: category.name,
                onPressed: () => controller.onCategoryPressed(category),
                isChecked: category == controller.selectedCategory,
              );
            },
          ),
        );
      },
    );
  }
}
