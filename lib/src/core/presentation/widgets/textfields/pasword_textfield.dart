import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextFormField extends StatefulWidget {
  final String? hintText;
  final bool enabled;
  final Function? onChanged;
  final TextEditingController? controller;
  final Function? validator;
  final Color? backgroundColor;

  const PasswordTextFormField({
    Key? key,
    this.hintText,
    this.enabled = true,
    this.onChanged,
    this.controller,
    this.validator,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        cursorColor: AppColors.red,
        style: theme.textTheme.bodySmall,
        obscureText: !_showPassword,
        keyboardType: TextInputType.text,
        maxLines: 1,
        enabled: true,
        validator: widget.validator as String? Function(String?)?,
        decoration: InputDecoration(
          fillColor: widget.backgroundColor??AppColors.topSheet,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 24.h,
            maxWidth: 32.h,
            minWidth: 32.h,
          ),
          suffixIconColor: AppColors.grey600,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 16.w,),
            child: InkWell(
              child: _showPassword?const Icon(Icons.visibility): const Icon(Icons.visibility_off),
              onTap: (){
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
          ),
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
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.grey500,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          enabled: widget.enabled,
        ),
      ),
    );
  }
}