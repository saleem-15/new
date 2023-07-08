import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: ManagerColors.greyPrimary,
        ),
        title: Text(
          ManagerStrings.termsAndConditionsTitle,
          style: getSemiBoldTextStyle(
            fontSize: ManagerFontSize.s24,
            color: ManagerColors.blackPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
              child: Text(
                ManagerStrings.termsAndConditionsPolicy,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.greyPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
