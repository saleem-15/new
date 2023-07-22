import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';

import '../../models/topic.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.topic,
  });

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.greyLighter,
        borderRadius: BorderRadius.all(
          Radius.circular(ManagerRadius.r12),
        ),
      ),
      child: Center(
        child: Text(
          topic.name,
          style: getSemiBoldTextStyle(
            fontSize: ManagerFontSize.s16,
            color: ManagerColors.greyDarker,
          ),
        ),
      ),
    );
  }
}
