import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield2.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenClassInvitation extends StatelessWidget {
  const ScreenClassInvitation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ContainerBg(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverCustomAppBar(
                title: LanguageKey.inviteStudents.tr,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: LanguageKey.youCanShareClassInvitationLink.tr,
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextSpan(text: " ",),
                          TextSpan(
                            text: LanguageKey.copyLink.tr,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColorLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 59.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.borderColorLight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.primaryColorLight,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              LanguageKey.phoneNumber.tr,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 59.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.borderColorLight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.white,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              LanguageKey.email.tr,
                              style: theme.textTheme.bodySmall?.copyWith(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Container(
                          height: 65.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.borderColorLight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.white,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: SizedBox(
                              height: 24.h,
                              width: 24.h,
                              child: Image.asset(
                                AppImages.iconPerson,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: AdvanceTextFormField2(
                            hintText: LanguageKey.phoneNumber.tr,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
              SliverList.builder(
                itemCount: 10,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: index>3,
                            fillColor: MaterialStateProperty.resolveWith((states) {
                              if (!states.contains(MaterialState.selected) && index==3) {
                                return const Color(0xffD9D9D9);
                              }
                              if (!states.contains(MaterialState.selected)) {
                                return Colors.white;
                              }
                              return null;
                            }),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: const BorderSide(
                              color: AppColors.textColorLabelLight,
                            ),
                            onChanged: (bool? value) {},
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LanguageKey.demoUserName.tr, style: theme.textTheme.bodyMedium),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                LanguageKey.demoPhoneNumber.tr,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textColorLabelLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        index == 3
                            ? Row(
                                children: [
                                  Image.asset(
                                    AppImages.iconCheck,
                                    width: 24.h,
                                    height: 24.h,
                                  ),
                                  SizedBox(width: 4.w,),
                                  Text(
                                    LanguageKey.sent.tr,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppColors.primaryColorLight,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Image.asset(
                                    AppImages.iconSend,
                                    width: 24.h,
                                    height: 24.h,
                                  ),
                                  SizedBox(width: 4.w,),
                                  Text(
                                    LanguageKey.send.tr,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppColors.primaryColorLight,
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          //vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BasicGradientButton(
              buttonText: "${LanguageKey.send.tr} (6)",
              backgroundColor: AppColors.primaryColorLight,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
