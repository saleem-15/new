import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';

import 'category_chip.dart';

enum CategoriesEnum {
  General,
  Business,
  Technology,
  Health,
  Entertainment,
  Science,
  Sports,
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return SizedBox(
          height: ManagerHeight.h34,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: ManagerWidth.w16,
            ),
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: ManagerWidth.w20,
            ),
            itemCount: CategoriesEnum.values.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = CategoriesEnum.values[index].name;
              
              return CategoryChip(
                text: category,
                onPressed: () => controller.onCategoryPressed(category),
                isChecked: category == controller.selctedCategory,
              );
            },
          ),
        );
      },
    );
  }
}
