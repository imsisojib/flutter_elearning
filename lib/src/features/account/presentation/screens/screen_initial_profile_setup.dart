import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_code/constants.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/dropdown/advance_dropdown.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/enums/enum_user_type.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenInitialProfileSetup extends StatefulWidget {
  const ScreenInitialProfileSetup({super.key});

  @override
  State<ScreenInitialProfileSetup> createState() => _ScreenInitialProfileSetupState();
}

class _ScreenInitialProfileSetupState extends State<ScreenInitialProfileSetup> {
  TextEditingController? firstNameTextEditingController;
  TextEditingController? lastNameEditingController;
  TextEditingController? emailTextEditingController;
  String? role;

  @override
  void initState() {
    firstNameTextEditingController = TextEditingController();
    lastNameEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameTextEditingController?.dispose();
    lastNameEditingController?.dispose();
    emailTextEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ProviderAccount>(builder: (_, accountProvider, child){
      return Scaffold(
        body: SingleChildScrollView(
          child: ContainerBg(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Text(
                  LanguageKey.lastStepFor.tr,
                  style: theme.textTheme.displayLarge,
                ),
                Text(
                  LanguageKey.registration.tr,
                  style: theme.textTheme.displayLarge,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    AdvanceTextFormField(
                      hintText: '${LanguageKey.firstName.tr} ${LanguageKey.requiredInBraked.tr}',
                      isMandatoryField: true,
                      controller: firstNameTextEditingController,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    AdvanceTextFormField(
                      hintText: '${LanguageKey.lastName.tr} ${LanguageKey.requiredInBraked.tr}',
                      isMandatoryField: true,
                      controller: lastNameEditingController,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    AdvanceTextFormField(
                      hintText: '${LanguageKey.email.tr} ${LanguageKey.optionalInBraked.tr}',
                      isMandatoryField: true,
                      controller: emailTextEditingController,
                    ),
                    // SizedBox(
                    //   height: 8.h,
                    // ),
                    // AdvanceDropDown<EUserRole>(
                    //   titleText: LanguageKey.registerAs.tr,
                    //   isMandatoryField: true,
                    //   hintText: LanguageKey.select.tr,
                    //   items: EUserRole.values
                    //       .map(
                    //         (e) => DropdownMenuItem(
                    //       value: e,
                    //       child: Text(e.name),
                    //     ),
                    //   )
                    //       .toList(),
                    //   onChanged: (EUserRole? value){
                    //     role = value?.name;
                    //   },
                    // ),
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100.h,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ProviderAccount>(builder: (_, providerAccount, child) {
                return accountProvider.loading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : BasicGradientButton(
                  buttonText: LanguageKey.continueText.tr,
                  buttonTextStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColorDark,
                  ),
                  backgroundColor: AppColors.primaryColorLight,
                  onPressed: () {
                    accountProvider.setupInitialProfile(
                      firstName: firstNameTextEditingController?.text,
                      lastName: lastNameEditingController?.text,
                      email: emailTextEditingController?.text,
                      role: role,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
