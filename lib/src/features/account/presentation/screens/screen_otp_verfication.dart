import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_gradient_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ScreenOtpVerification extends StatefulWidget {
  const ScreenOtpVerification({Key? key}) : super(key: key);

  @override
  State<ScreenOtpVerification> createState() => _ScreenOtpVerificationState();
}

class _ScreenOtpVerificationState extends State<ScreenOtpVerification> {
  String otpCode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderAccount>(builder: (_, providerAccount, child) {
      return Scaffold(
        body: ContainerBg(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(
                LanguageKey.enterTheVerificationCode.tr,
                style: theme.textTheme.displayLarge,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                LanguageKey.otp6NumbersWillBeSentForVerification.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              PinCodeTextField(
                appContext: context,
                length: 6,
                hintCharacter: 'x',
                keyboardType: TextInputType.number,
                obscureText: false,
                errorTextSpace: 0,
                animationType: AnimationType.fade,
                textStyle: theme.textTheme.displayMedium,
                cursorColor: theme.colorScheme.onBackground,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(16),
                  fieldHeight: 55.h,
                  fieldWidth: 55.h,
                  borderWidth: 1,
                  //errorBorderColor: AppColors.grey75.withOpacity(.2),
                  activeFillColor: AppColors.white,
                  inactiveFillColor: AppColors.white,
                  selectedFillColor: AppColors.white,

                  activeColor: AppColors.red,
                  inactiveColor: AppColors.grey400,
                  disabledColor: AppColors.grey400,
                  selectedColor: AppColors.grey400,
                ),
                animationDuration: const Duration(milliseconds: 300),
                //backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                //errorAnimationController: errorController,
                //controller: textEditingController,
                onCompleted: (String v) {
                  otpCode = v;
                },
                onChanged: (value) {
                  otpCode = value;
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      providerAccount.resendOtpCode();
                    },
                    child: Text(
                      LanguageKey.resendOTPCode.tr,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.lightBlueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              )
            ],
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
                        buttonTextStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColorDark,
                        ),
                        backgroundColor: AppColors.primaryColorLight,
                        onPressed: () {
                          if (otpCode.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please provider OTP code!",
                            );
                            return;
                          }

                          providerAccount.signInWithPhoneNumber(
                            otpCode: otpCode,
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
