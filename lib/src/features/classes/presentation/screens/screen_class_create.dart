import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield2.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenClassCreate extends StatelessWidget {
  const ScreenClassCreate({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ContainerBg(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverCustomAppBar(title: "Create Class"),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdvanceTextFormField2(
                      hintText: "Chapter Title (required)",
                    ),
                    AdvanceTextFormField2(
                      hintText: "A wish that separates from to",
                      prefixIcon: SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Image.asset(
                          AppImages.iconDateEdit,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      "Choose class times during the semester",
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      "(Example: Two classes each week, on Mondays and Thursdays at 6 p.m.)",
                      style: theme.textTheme.labelMedium,
                    ),
                    SizedBox(height: 8.h,),
                    AdvanceTextFormField2(
                      hintText: "Every Week",
                      prefixIcon: SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Image.asset(
                          AppImages.iconRefresh,
                        ),
                      ),
                    ),
                    AdvanceTextFormField2(
                      hintText: "Two Hours",
                      prefixIcon: SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Image.asset(
                          AppImages.iconBottomArrow,
                        ),
                      ),
                    ),
                    AdvanceTextFormField2(
                      hintText: "Saturday Wednesday",
                      prefixIcon: SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Image.asset(
                          AppImages.iconCalendar,
                        ),
                      ),
                    ),
                    AdvanceTextFormField2(
                      titleText: "Saturday Class Time",
                      tittleTextStyle: theme.textTheme.bodyLarge,
                      hintText: "Select",
                      prefixIcon: SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Image.asset(
                          AppImages.iconTimer,
                        ),
                      ),
                    ),

                    AdvanceTextFormField2(
                      titleText: "Wednesday Class Time",
                      tittleTextStyle: theme.textTheme.bodyLarge,
                      hintText: "Select",
                      prefixIcon: SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Image.asset(
                          AppImages.iconTimer,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicGradientButton(
              buttonText: "Create Class",
              backgroundColor: AppColors.primaryColorLight,
              onPressed: () {

              },
            )
          ],
        ),
      ),
    );
  }
}
