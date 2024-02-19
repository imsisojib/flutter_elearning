import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_checkbox_state.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield2.dart';
import 'package:flutter_boilerplate_code/src/features/classes/presentation/providers/provider_invitations.dart';
import 'package:flutter_boilerplate_code/src/features/classes/presentation/widgets/invitation_tile.dart';
import 'package:flutter_boilerplate_code/src/features/classes/presentation/widgets/invitation_tile_disabled.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenClassInvitation extends StatelessWidget {
  const ScreenClassInvitation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ProviderInvitations>(builder: (_, providerInvitations, child) {
      return Scaffold(
        body: SafeArea(
          child: ContainerBg(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverCustomAppBar(
                  title: LanguageKey.inviteStudents.tr,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: LanguageKey.youCanShareClassInvitationLink.tr,
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: LanguageKey.copyLink.tr,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryColorLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 59.h,
                            width: 115.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.borderColorLight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.primaryColorLight,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                LanguageKey.phoneNumber.tr,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            height: 59.h,
                            width: 115.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.borderColorLight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                LanguageKey.email.tr,
                                style: theme.textTheme.bodySmall?.copyWith(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          InkWell(
                            onTap: () {
                              providerInvitations.loadContacts();
                            },
                            child: Container(
                              height: 65.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.borderColorLight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.white,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                child: SizedBox(
                                  height: 24.h,
                                  width: 24.h,
                                  child: Image.asset(
                                    AppImages.iconPerson,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                            child: AdvanceTextFormField2(
                              hintText: LanguageKey.phoneNumber.tr,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
                providerInvitations.loading == ELoading.loading
                    ? const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SliverList.builder(
                        itemCount: providerInvitations.contacts.length,
                        itemBuilder: (_, index) {
                          //if (index == 3) return const InvitationTileDisabled();

                          return InvitationTile(
                            contact: providerInvitations.contacts[index],
                            state: providerInvitations.selectedContacts
                                    .contains(providerInvitations.contacts[index])
                                ? ECheckBoxState.checked
                                : ECheckBoxState.unChecked,
                            onRemoveSelected: (){
                              providerInvitations.removeSelectedContact(providerInvitations.contacts[index]);
                            },
                            onSelected: (){
                              providerInvitations.addSelectedContact(providerInvitations.contacts[index]);
                            },

                          );
                        },
                      ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 110.h,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            //vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BasicGradientButton(
                buttonText: "${LanguageKey.send.tr} (${providerInvitations.selectedContacts.length})",
                backgroundColor: AppColors.primaryColorLight,
                onPressed: () {},
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  LanguageKey.later.tr,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: const Color(0xff24CCA8),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
