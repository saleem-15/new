import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/widgets/screen_header.dart';
import 'package:nuntium/features/category/presentation/controller/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(
                title: 'Categories',
                paragraph: 'Thousands of articles in each category',
              ),
              GetBuilder<CategoriesController>(
                builder: (_) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.topics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ManagerWidth.w16,
                        mainAxisSpacing: ManagerHeight.h16,
                        childAspectRatio: 160 / 72),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: ManagerColors.greyLighter,
                          borderRadius: BorderRadius.all(
                            Radius.circular(ManagerRadius.r12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            controller.topics[index].name,
                            style: getSemiBoldTextStyle(
                              fontSize: ManagerFontSize.s16,
                              color: ManagerColors.greyDarker,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
