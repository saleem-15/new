import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/features/bookmarks/presentation/view/bookmarks_view.dart';
import 'package:nuntium/features/category/presentation/view/categories_view.dart';
import 'package:nuntium/features/home/presentation/view/home_view.dart';
import 'package:nuntium/features/profile/presentation/view/profile_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class MainController extends GetxController {
  final persistentTabController = PersistentTabController();

  List<Widget> screens = [
    const HomeView(),
    const CategoriesView(),
    const BookmarksView(),
    const ProfileView()
  ];

  static const iconSize = ManagerIconSize.s24;
  static const activeIconColor = ManagerColors.purplePrimary;
  static const inactiveIconColor = ManagerColors.greyLight;

  late List<PersistentBottomNavBarItem> bottomNavBarItems = [
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        VectorIcons.home,
      ),
      iconSize: iconSize,
      activeColorPrimary: activeIconColor,
      inactiveColorPrimary: inactiveIconColor,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        VectorIcons.category,
      ),
      iconSize: iconSize,
      activeColorPrimary: activeIconColor,
      inactiveColorPrimary: inactiveIconColor,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        VectorIcons.bookmark,
      ),
      iconSize: iconSize,
      activeColorPrimary: activeIconColor,
      inactiveColorPrimary: inactiveIconColor,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        VectorIcons.user,
      ),
      iconSize: iconSize,
      activeColorPrimary: activeIconColor,
      inactiveColorPrimary: inactiveIconColor,
    ),
  ];
}
