import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceDropDown<T> extends StatelessWidget {
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
  final TextEditingController? controller;
  final Function? validator;
  final Color? backgroundColor;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final double? width;

  const AdvanceDropDown({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.validator,
    this.value,
    this.backgroundColor,
    this.maxLength,
    this.maxLines,
    required this.items,
    this.width,
    this.titleText,
    this.tittleTextStyle,
    this.additionalTittleText,
    this.isMandatoryField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        titleText == null
            ? const SizedBox()
            : Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      additionalTittleText ?? "",
                      style: theme.textTheme.labelSmall,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DropdownButtonFormField<T?>(
            value: value,
            items: items,
            onChanged: (T? value){
              onChanged?.call(value);
            },
            decoration: InputDecoration(
              fillColor: backgroundColor??AppColors.topSheet,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
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