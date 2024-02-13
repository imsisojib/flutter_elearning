import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_checkbox_state.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckBox extends StatelessWidget {
  final ECheckBoxState state;

  const CustomCheckBox({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31.h,
      width: 31.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.w),
        border: Border.all(color: const Color(0xff000000).withOpacity(.2)),
        color: state == ECheckBoxState.checked
            ? AppColors.primaryColorLight
            : state == ECheckBoxState.disabled
                ? const Color(0xffD9D9D9)
                : Colors.white,
      ),
      child: state == ECheckBoxState.checked
          ? Center(
              child: Image.asset(
                AppImages.iconCheckWhite,
                width: 24.h,
                height: 24.h,
              ),
            )
          : const SizedBox(),
    );
  }
}
