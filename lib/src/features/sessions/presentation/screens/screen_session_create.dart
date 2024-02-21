import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_checkbox_state.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/dropdown/advance_dropdown.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/dropdown/advance_dropdown2.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_selection2.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield2.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/models/day.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/models/recurrence.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/data/requestbodys/requestbody_session.dart';
import 'package:flutter_boilerplate_code/src/features/sessions/presentation/providers/provider_sessions.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenSessionCreate extends StatefulWidget {
  const ScreenSessionCreate({super.key});

  @override
  State<ScreenSessionCreate> createState() => _ScreenSessionCreateState();
}

class _ScreenSessionCreateState extends State<ScreenSessionCreate> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderSessions>(context, listen: false).initializeSessionCreation();
    });
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<ProviderSessions>(context, listen: false).disposeSessionCreation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ProviderSessions>(builder: (_, providerSessions, child) {

      return Scaffold(
        body: SafeArea(
          child: ContainerBg(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverCustomAppBar(
                  title: LanguageKey.createClass.tr,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AdvanceTextFormField2(
                        hintText:
                            "${LanguageKey.chapterTitle.tr} ${LanguageKey.requiredInBraked.tr}",
                        initialValue: providerSessions.requestBodySession?.title,
                        onChanged: (String value) {
                          var data = providerSessions.requestBodySession;
                          data?.title = value;
                          providerSessions.requestBodySession = data;
                        },
                      ),
                      AdvanceTextFormField2(
                        hintText: LanguageKey.separationPeriodFromTo.tr,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true,),
                        prefixIcon: SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: Image.asset(
                            AppImages.iconDateEdit,
                          ),
                        ),
                        onChanged: (String value){
                          var data = providerSessions.requestBodySession;
                          data?.duration = value;
                          providerSessions.requestBodySession = data;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        LanguageKey.chooseClassTimesDuringSemester.tr,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        LanguageKey.chooseClassTimesDuringSemesterExample.tr,
                        style: theme.textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AdvanceDropDown2<Recurrence>(
                        onChanged: (Recurrence value){
                          var data = providerSessions.requestBodySession;
                          data?.recurrence = value;
                          //data?.lessonCount = value.value;
                          data?.lessonCountList.clear();
                          for(int i=1; i<=value.value!; i++){
                            data?.lessonCountList.add(i);
                          }
                          providerSessions.requestBodySession = data;
                        },
                        items: providerSessions.recurrences!.map((e) {
                          return DropdownMenuItem<Recurrence>(
                            value: e,
                            child: Text(e.ar ?? ""),
                          );
                        }).toList(),
                        icon: SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: Image.asset(
                            AppImages.iconRefresh,
                          ),
                        ),
                        hintText: LanguageKey.selectWeek.tr,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AdvanceDropDown2<int>(
                        onChanged: (int value){
                          var data = providerSessions.requestBodySession;
                          data?.lessonCount = value;
                          providerSessions.requestBodySession = data;

                        },
                        items: providerSessions.requestBodySession!.lessonCountList.map((e) {
                          return DropdownMenuItem<int>(
                            value: e,
                            child: Text("$e"),
                          );
                        }).toList(),
                        icon: SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: Image.asset(
                            AppImages.iconBottomArrow,
                          ),
                        ),
                        hintText: LanguageKey.selectHours.tr,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AdvanceSelection2(
                        hintText: LanguageKey.selectDays.tr,
                        initialValue: providerSessions.requestBodySession?.getDaysStringAr(),
                        prefixIcon: SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: Image.asset(
                            AppImages.iconCalendar,
                          ),
                        ),
                        onStartSelection: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              useRootNavigator: true,
                              useSafeArea: true,
                              builder: (_) {
                                return StatefulBuilder(builder: (_, state) {
                                  return Selector<ProviderSessions, RequestBodySession?>(
                                    shouldRebuild: (old, updated) => true,
                                    builder: (_, requestBodySession, child) {
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                            ),
                                            Text(
                                              LanguageKey.selectDays.tr,
                                              style: theme.textTheme.displayMedium,
                                            ),
                                            ListView.separated(
                                              itemBuilder: (_, index) {
                                                return Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    CustomCheckBox(
                                                      state: requestBodySession?.lessonDays
                                                                  ?.contains(providerSessions
                                                                      .days?[index]) ??
                                                              false
                                                          ? ECheckBoxState.checked
                                                          : ECheckBoxState.unChecked,
                                                      onSelected: () {
                                                        var data =
                                                            providerSessions.requestBodySession;
                                                        data?.lessonDays ??= [];
                                                        data?.lessonDays
                                                            ?.add(providerSessions.days![index]);
                                                        providerSessions.requestBodySession = data;
                                                      },
                                                      onRemoveSelected: () {
                                                        var data =
                                                            providerSessions.requestBodySession;
                                                        data?.lessonDays ??= [];
                                                        data?.lessonDays
                                                            ?.remove(providerSessions.days![index]);
                                                        providerSessions.requestBodySession = data;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 16.w,
                                                    ),
                                                    Text(
                                                      providerSessions.days?[index].ar ?? "",
                                                      style: theme.textTheme.titleMedium,
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder: (_, index) {
                                                return SizedBox(
                                                  height: 8.h,
                                                );
                                              },
                                              itemCount: providerSessions.days!.length,
                                              shrinkWrap: true,
                                            ),
                                            SizedBox(
                                              height: 24.h,
                                            ),
                                            BasicGradientButton(
                                              buttonText: LanguageKey.continueText.tr,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    selector: (_, providerSessions) =>
                                        providerSessions.requestBodySession,
                                  );
                                });
                              });
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      !providerSessions.requestBodySession!.sameTiming
                          ? AdvanceSelection2(
                              initialValue: providerSessions.requestBodySession?.sessionTimingForAll,
                              //textDirection: TextDirection.ltr,
                              //textAlign: TextAlign.end,
                              hintText: LanguageKey.selectTime.tr,
                              prefixIcon: SizedBox(
                                height: 24.h,
                                width: 24.h,
                                child: Image.asset(
                                  AppImages.iconTimer,
                                ),
                              ),
                              onStartSelection: () async {
                                var pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  var data = providerSessions.requestBodySession;
                                  data?.sessionTiming ??= {};
                                  data?.sessionTimingForAll =
                                      "${pickedTime.hourOfPeriod}:${pickedTime.minute} ${pickedTime.period.name}";
                                  providerSessions.requestBodySession = data;
                                }
                              },
                            )
                          : const SizedBox(),
                      !providerSessions.requestBodySession!.sameTiming
                          ? TextButton(
                              onPressed: () {
                                var data = providerSessions.requestBodySession;
                                data?.sessionTiming ??= {};
                                data?.sameTiming = !data.sameTiming;
                                providerSessions.requestBodySession = data;
                              },
                              child: Text(
                                LanguageKey.allocateDifferentTimeForEachClass.tr,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primaryColorLight,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      providerSessions.requestBodySession!.sameTiming
                          ? Column(
                              children: providerSessions.requestBodySession!.lessonDays!.map((day) {
                                return Column(
                                  children: [
                                    AdvanceSelection2(
                                      //textAlign: TextAlign.end,
                                      //textDirection: TextDirection.ltr,
                                      titleText: "${LanguageKey.classTime.tr} ${day.ar}",
                                      initialValue:
                                      providerSessions.requestBodySession?.sessionTiming?[day.slug],
                                      tittleTextStyle: theme.textTheme.bodyLarge,
                                      hintText: LanguageKey.select.tr,
                                      prefixIcon: SizedBox(
                                        height: 24.h,
                                        width: 24.h,
                                        child: Image.asset(
                                          AppImages.iconTimer,
                                        ),
                                      ),
                                      onStartSelection: () async {
                                        var pickedTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (pickedTime != null) {
                                          var data = providerSessions.requestBodySession;
                                          data?.sessionTiming ??= {};
                                          data?.sessionTiming?[day.slug!] =
                                          "${pickedTime.hourOfPeriod}:${pickedTime.minute} ${pickedTime.period.name}";
                                          providerSessions.requestBodySession = data;
                                        }
                                      },
                                    ),
                                    SizedBox(height: 8.h,),
                                  ],
                                );
                              }).toList(),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            //vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              providerSessions.loading==ELoading.submitLoading?const Center(child: CircularProgressIndicator(),):BasicGradientButton(
                buttonText: LanguageKey.saveAndContinue.tr,
                backgroundColor: AppColors.primaryColorLight,
                onPressed: () {
                  providerSessions.createSession();
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
