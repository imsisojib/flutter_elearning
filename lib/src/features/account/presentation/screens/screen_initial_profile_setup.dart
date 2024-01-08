import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_code/constants.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/dropdown/advance_dropdown.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/enums/enum_user_type.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenInitialProfileSetup extends StatefulWidget {
  const ScreenInitialProfileSetup({super.key});

  @override
  State<ScreenInitialProfileSetup> createState() => _ScreenInitialProfileSetupState();
}

class _ScreenInitialProfileSetupState extends State<ScreenInitialProfileSetup> {
  TextEditingController? nameTextEditingController;
  String? role;

  @override
  void initState() {
    nameTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameTextEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24.h),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Consumer<ProviderAccount>(
          builder: (_, accountProvider, child) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          Constants.appName,
                          style: theme.textTheme.headline5?.copyWith(color: const Color(0xffEC6375)), //TODO:
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'Setup Your Initial Profile',
                      style: theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    /*Image.asset(
                      AppImages.placeholderProfile,
                      height: 100.h,
                      width: 100.h,
                    ),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        AdvanceTextFormField(
                          titleText: "Full Name",
                          hintText: 'Enter Your Full Name',
                          isMandatoryField: true,
                          controller: nameTextEditingController,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        AdvanceDropDown<EUserRole>(
                          titleText: "Join As",
                          hintText: "Select",
                          items: EUserRole.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (EUserRole? value){
                            role = value?.name;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    accountProvider.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : BasicButton(
                            buttonText: 'Done',
                            onPressed: () {
                              accountProvider.setupInitialProfile(
                                name: nameTextEditingController?.text,
                                role: role,
                              );
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
