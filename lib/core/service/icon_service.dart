import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';

class IconService {
  IconService._();

  static final Map<IconData, IconData> icons = {
    ManagerIcons.arrow_back_android: ManagerIcons.arrow_back_ios,
  };

  static IconData? getPlatformIcon(IconData icon) {
    if (Platform.isIOS) {
      if (icons.containsKey(icon)) {
        return icons[icon];
      } else if (icons.containsValue(icon)) {
        return icon;
      }
    } else {
      if (icons.containsKey(icon)) {
        return icon;
      } else if (icons.containsValue(icon)) {
        return icons.entries.firstWhere((entry) => entry.value == icon).key;
      }
    }
    return icon;
  }

  static Widget getIcon({required dynamic icon, Color? color, double iconSize = ManagerIconSize.s24}) {
    if (icon is IconData) {
      return Icon(
        getPlatformIcon(icon),
        color: color ?? ManagerColors.greyPrimary,
        size: iconSize,
      );
    } else if (icon is String && icon.endsWith('.svg')) {
      return SvgPicture.asset(
        icon,
        width: iconSize,
        height: iconSize,
      );
    }

    throw Exception('icon must be of type (IconData) Or (String) not type $icon' '${StackTrace.current}');
  }
}
