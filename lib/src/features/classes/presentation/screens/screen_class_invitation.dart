import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield2.dart';
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
              const SliverCustomAppBar(title: "Invite Students"),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "You can share a link to the class invitation ",
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: "Copy the link",
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
                              "Phone Number",
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
                              "Email",
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
                            hintText: "Enter Phone Number",
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
                            value: index == 0,
                            fillColor: MaterialStateProperty.resolveWith((states) {
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
                              Text(
                                "Demo User Name",
                                style: theme.textTheme.bodyMedium
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "011660000089",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textColorLabelLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        index == 0
                            ? Row(
                                children: [
                                  Image.asset(
                                    AppImages.iconCheck,
                                    width: 24.h,
                                    height: 24.h,
                                  ),
                                  Text(
                                    "Invited",
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
                                  Text(
                                    "Invite",
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
              buttonText: "Invite",
              backgroundColor: AppColors.primaryColorLight,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
