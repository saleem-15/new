import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/widgets/will_pop_scope.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../controller/main_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return willPopScope(
      child: GetBuilder<MainController>(
        builder: (controller) {
          return PersistentTabView(
            context,
            controller: controller.persistentTabController,
            navBarStyle: NavBarStyle.style14,
            backgroundColor: Colors.white,
            confineInSafeArea: true,
            navBarHeight: ManagerHeight.h90,
            //must be the same value like [navBarHeight] so the screen doesn't go behind navBar
            bottomScreenMargin: ManagerHeight.h90,
            decoration: NavBarDecoration(
              colorBehindNavBar: ManagerColors.white,
              border: Border.all(
                color: ManagerColors.greyLight.withOpacity(.32),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ManagerRadius.r16),
                topRight: Radius.circular(ManagerRadius.r16),
              ),
            ),
            resizeToAvoidBottomInset: false,
            screens: controller.screens,
            items: controller.bottomNavBarItems,
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
            ),
          );
        },
      ),
    );
  }
}
