import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpVerifiedView extends StatelessWidget{
  const OtpVerifiedView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LanguageKey.verified.tr,
            style: theme.textTheme.displayLarge,
          ),
          SizedBox(height: 8.h,),
          Text(
            LanguageKey.congratulationsPhoneNumberVerified.tr,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.grey600,
            ),
          ),
          SizedBox(height: 32.h,),
          Image.asset(
            AppImages.graphicDone,
            height: 100.h,
            width: 100.h,
          ),
        ],
      ),
    );
  }
}