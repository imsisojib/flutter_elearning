import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicGradientButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double elevation;
  final Color? backgroundColor;
  final Function? onPressed;
  final Widget? suffix;
  final Widget? prefix;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final double borderRadius;
  final TextAlign? textAlign;
  final MainAxisAlignment? mainAxisAlignment;

  const BasicGradientButton({
    super.key,
    this.width,
    this.height = 60,
    this.backgroundColor = AppColors.red,
    this.onPressed,
    this.suffix,
    this.prefix,
    required this.buttonText,
    this.buttonTextStyle,
    this.elevation = 1,
    this.borderRadius = 50,
    this.textAlign,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        elevation: elevation,
        height: height!.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.h),
        ),
        onPressed: () {
          onPressed?.call();
        },
        child: Container(
          height: height!.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius.h),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color((0xff24CCA8)),
                Color((0xff29E4BC)),
                Color((0xff29E4BC)),
                Color((0xffB0FDEC)),
              ]
            )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: mainAxisAlignment!,
            children: [
              prefix ?? const SizedBox(),
              Text(
                buttonText,
                style: buttonTextStyle ??
                    theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColorDark,
                    ),
                textAlign: textAlign,
              ),
              suffix ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
