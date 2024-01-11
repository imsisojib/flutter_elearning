import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  Country? _initialCountry;
  TextEditingController? phoneTextEditingController;

  @override
  void initState() {
    _initialCountry = CountryParser.parseCountryCode("EG");
    phoneTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneTextEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 24.h,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffD2F2F0),
                AppColors.scaffoldColorLight,
                AppColors.scaffoldColorLight,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80.h,
              ),
              Text(
                LanguageKey.enterYourPhoneNumber.tr,
                style: theme.textTheme.displayLarge,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                LanguageKey.toRegister.tr,
                style: theme.textTheme.displayLarge,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                LanguageKey.afterEnteringThePhoneNumber6digits.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              Text(
                LanguageKey.otpCodeWillBeSend.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 65.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.grey400),
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.white,
                ),
                padding: const EdgeInsets.all(2),
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              showPhoneCode: true,
                              context: context,
                              onSelect: (Country country) {
                                setState(() {
                                  _initialCountry = country;
                                });
                              },
                              countryListTheme: const CountryListThemeData(
                                backgroundColor: AppColors.scaffoldColorLight,
                              ));
                        },
                        child: Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            Text(
                              WidgetHelper.countryCodeToEmoji(_initialCountry?.countryCode),
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 18,
                              color: AppColors.textColorLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      "|",
                      style: TextStyle(
                        fontSize: 33,
                        color: AppColors.grey400,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LanguageKey.phoneNumber.tr,
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey500,
                          ),
                          fillColor: AppColors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text(
              //       LanguageKey.withoutCountryCode.tr,
              //       style: theme.textTheme.bodyMedium?.copyWith(
              //         color: AppColors.grey600,
              //       ),
              //     ),
              //     Text(
              //       "+${_initialCountry?.phoneCode}",
              //       style: theme.textTheme.bodyMedium?.copyWith(
              //         fontWeight: FontWeight.w600,
              //       ),
              //       textDirection: TextDirection.ltr,
              //     )
              //   ],
              // ),

              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "${LanguageKey.loginWithParentCode.tr} ",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                  TextSpan(
                    text: LanguageKey.enterTheCode.tr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.lightBlueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ]),
              ),

              SizedBox(
                height: 20,
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
              return providerAccount.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : BasicGradientButton(
                      buttonText: LanguageKey.continueText.tr,
                      backgroundColor: AppColors.primaryColorLight,
                      onPressed: () {
                        if (phoneTextEditingController?.text.isEmpty ?? true) {
                          Fluttertoast.showToast(msg: "Please provide valid phone number!");
                          return;
                        }
                        providerAccount.sentOtpCode(
                          phoneNumber: "+${_initialCountry?.phoneCode}${phoneTextEditingController?.text}",
                        );
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
