import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_checkbox_state.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationTile extends StatelessWidget {
  final ECheckBoxState state;
  final Contact contact;
  final Function? onSelected;
  final Function? onRemoveSelected;

  const InvitationTile(
      {super.key,
      required this.state,
      required this.contact,
      this.onSelected,
      this.onRemoveSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.h,
      ),
      child: Row(
        children: [
          CustomCheckBox(
            state: state,
            onSelected: onSelected,
            onRemoveSelected: onRemoveSelected,
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.displayName, style: theme.textTheme.bodyMedium),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  contact.phones.isNotEmpty?contact.phones.first.normalizedNumber:"N/A",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textColorLabelLight,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Image.asset(
                AppImages.iconSend,
                width: 24.h,
                height: 24.h,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                LanguageKey.send.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xff24CCA8),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
