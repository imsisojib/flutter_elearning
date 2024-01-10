import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationCompletedView extends StatelessWidget{
  const RegistrationCompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LanguageKey.registrationIsSuccessful.tr,
            style: theme.textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h,),
          Text(
            LanguageKey.congratulationsPhoneNumberVerified.tr,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h,),
          Icon(
            Icons.check_circle_outline,
            size: 100.h,
            color: AppColors.red,
          )
        ],
      ),
    );
  }
}