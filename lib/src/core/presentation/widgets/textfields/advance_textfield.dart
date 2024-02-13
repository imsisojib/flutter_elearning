import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceTextFormField extends StatelessWidget {
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

  const AdvanceTextFormField({
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
          TextFormField(
            initialValue: initialValue,
            controller: controller,
            onChanged: (value) {
              onChanged?.call(value);
            },
            onTapOutside: (event){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            cursorColor: AppColors.red,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 18.sp,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            maxLength: maxLength,
            maxLines: maxLines,
            validator: validator as String? Function(String?)?,
            decoration: InputDecoration(
              fillColor: backgroundColor ?? fillColor,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              //prefixIcon: prefixIcon,
              prefixIcon: prefixIcon,
              // prefixIconConstraints: BoxConstraints(
              //   maxHeight: 16.h,
              // ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
              ),
              hintText: hintText,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textColorLabelLight,
                fontSize: 18.sp,
              ),
              enabled: enabled,
            ),
          ),
        ],
      ),
    );
  }
}
