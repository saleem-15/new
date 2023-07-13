import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingArticlesIndicator(BuildContext _) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: List.generate(
        3,
        (_) => Container(
          margin: EdgeInsets.only(
            right: ManagerWidth.w20,
            left: ManagerWidth.w20,
            bottom: ManagerHeight.h24,
          ),
          height: ManagerHeight.h272,
          width: ManagerWidth.w375,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ManagerRadius.r16),
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
