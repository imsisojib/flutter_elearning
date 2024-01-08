import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BasicTextField extends StatelessWidget{
  final String? initialValue;
  final String? hintText;
  final String? tittleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
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
  final int? maxLength;

  const BasicTextField({Key? key, this.tittleText, this.additionalTittleText, this.controller, this.inputType, this.hintText,this.onChanged,this.isPassword=false,this.isMandatoryField=false,this.isPasswordVisible=false, this.tittleTextStyle, this.backgroundColor, this.initialValue, this.textAlign, this.maxLines=1, this.cursorColor, this.filledColor, this.filled=true, this.hintTextStyle, this.textStyle, this.height = 50, this.maxLength, this.inputFormatters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      //maxLength: maxLength,
      initialValue: initialValue,
      onChanged: (value){
        if(onChanged != null) onChanged!(value);
      },
      textAlign: textAlign??TextAlign.start,
      controller: controller,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: textStyle??theme.textTheme.bodySmall?.copyWith(color: AppColors.textColorLight,),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        fillColor: filledColor??backgroundColor,
        filled: filled,
        contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
        //isDense: true,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: hintTextStyle??theme.textTheme.labelMedium?.copyWith(color: AppColors.textColorLight.withOpacity(.5),),

      ),
    );
  }

}