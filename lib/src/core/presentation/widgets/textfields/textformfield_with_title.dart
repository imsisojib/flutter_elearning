import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWithTitle extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String? tittleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Function? onChanged;
  final bool isPassword;
  final bool isPasswordVisible;
  final bool isMandatoryField;
  final Color? backgroundColor;
  final Color? cursorColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool filled;
  final Color? filledColor;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final double? height;
  final Widget? prefixIcon;
  final bool enabled;
  final Widget? action;

  const TextFormFieldWithTitle({
    Key? key,
    this.tittleText,
    this.additionalTittleText,
    this.controller,
    this.inputType,
    this.hintText,
    this.onChanged,
    this.isPassword = false,
    this.isMandatoryField = false,
    this.isPasswordVisible = false,
    this.tittleTextStyle,
    this.backgroundColor,
    this.initialValue,
    this.textAlign,
    this.maxLines = 1,
    this.cursorColor,
    this.filledColor,
    this.filled = true,
    this.hintTextStyle,
    this.textStyle,
    this.height = 60,
    this.prefixIcon,
    this.enabled = true,
    this.inputAction = TextInputAction.done,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: tittleText == null ? false : true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          tittleText ?? "",
                          style: theme.textTheme.labelMedium,
                        ),
                        isMandatoryField
                            ? Text(
                                "*",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.red,
                                ),
                              )
                            : const Text(""),
                        Text(
                          additionalTittleText ?? "",
                          style: theme.textTheme.labelSmall,
                        ),
                        SizedBox(width: 8.w,),
                        action??const SizedBox(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            initialValue: initialValue,
            controller: controller,
            maxLines: maxLines,
            onChanged: (value) {
              onChanged?.call(value);
            },
            cursorColor: AppColors.red,
            style: theme.textTheme.bodyMedium,
            //obscureText: obscureText,
            keyboardType: inputType,
            textInputAction: inputAction,
            //validator: validator as String? Function(String?)?,
            decoration: InputDecoration(
              fillColor: AppColors.grey75.withOpacity(.15),
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.grey75.withOpacity(0.2),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.grey75.withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.primaryColorLight.withOpacity(0.8),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.grey75.withOpacity(0.2),
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.grey500,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              enabled: enabled,
            ),
          ),
        ),
      ],
    );
  }
}
