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
  final Icon? prefixIcon;
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
    return Column(
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
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.grey400,
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            initialValue: initialValue,
            controller: controller,
            onChanged: (value) {
              onChanged?.call(value);
            },
            onTapOutside: (event){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            cursorColor: AppColors.red,
            style: theme.textTheme.bodySmall,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            maxLength: maxLength,
            maxLines: maxLines,
            validator: validator as String? Function(String?)?,
            decoration: InputDecoration(
              fillColor: backgroundColor ?? AppColors.topSheet,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.popupStroke,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.popupStroke,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.popupStroke,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.popupStroke,
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
