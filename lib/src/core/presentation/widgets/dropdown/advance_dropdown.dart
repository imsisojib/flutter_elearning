import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceDropDown<T> extends StatelessWidget {
  final String? hintText;
  final String? titleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final bool isMandatoryField;
  final Icon? prefixIcon;
  final bool enabled;
  final Function? onChanged;
  final Color? backgroundColor;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final double? width;

  const AdvanceDropDown({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    this.onChanged,
    this.value,
    this.backgroundColor,
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

    //for dark and light theme
    Color fillColor = theme.brightness==Brightness.light? AppColors.white : AppColors.topSheet;
    Color borderColor = theme.brightness==Brightness.light? AppColors.grey400 : AppColors.popupStroke;

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
              fillColor: backgroundColor?? fillColor,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              hintText: hintText,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey400,
              ),
              enabled: enabled,
            ),
          ),
        ),
      ],
    );
  }
}