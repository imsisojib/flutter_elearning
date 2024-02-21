import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceTextFormField2 extends StatelessWidget {
  final String? hintText;
  final String? titleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final bool isMandatoryField;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefixIcon;
  final bool enabled;
  final bool obscureText;
  final Function? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Function? validator;
  final String? initialValue;
  final Color? backgroundColor;

  const AdvanceTextFormField2({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.validator,
    this.initialValue,
    this.backgroundColor,
    this.maxLength,
    this.maxLines = 1,
    this.titleText,
    this.tittleTextStyle,
    this.additionalTittleText,
    this.isMandatoryField = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    //for dark and light theme
    Color fillColor = theme.brightness==Brightness.light? AppColors.white : AppColors.topSheet;
    Color borderColor = theme.brightness==Brightness.light? AppColors.borderColorLight : AppColors.popupStroke;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h,),
      child: Column(
        children: [
          titleText == null
              ? const SizedBox()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    titleText ?? "",
                    style: tittleTextStyle??theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                  isMandatoryField
                      ? Text(
                    " *",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.red,
                    ),
                  )
                      : const Text(""),
                ],
              ),
              additionalTittleText==null?const SizedBox(): Text(
                additionalTittleText ?? "",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
          Container(
            height: 65.h,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: borderColor,),
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
            ),
            padding: const EdgeInsets.all(2),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                prefixIcon==null?const SizedBox(): Row(
                  children: [
                    SizedBox(
                      width: 8.w,
                    ),
                    prefixIcon??const SizedBox(),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),

                Expanded(
                  child: TextFormField(
                    initialValue: initialValue,
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textColorInputLight,
                    ),
                    onChanged: (String value){
                      onChanged?.call(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.textColorLabelLight,
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
