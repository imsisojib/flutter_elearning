import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/language/application/translation_extention.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_key.dart';
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
  String _initialCountryCode = "+20";
  TextEditingController? phoneTextEditingController;

  @override
  void initState() {
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
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Text(
              LanguageKey.enterYourPhoneNumberToRegister.tr,
              style: theme.textTheme.displayLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              LanguageKey.afterEnteringThePhoneNumber6digits.tr,
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              LanguageKey.otpCodeWillBeSend.tr,
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 65.h,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.grey400),
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
              ),
              padding: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          showPhoneCode: true,
                          context: context,
                          onSelect: (Country country) {
                            setState(() {
                              _initialCountryCode = "+${country.phoneCode}";
                            });
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          _initialCountryCode,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
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
                        fillColor: AppColors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ProviderAccount>(builder: (_, providerAccount, child) {
              return SizedBox(
                width: double.infinity,
                height: 45,
                child: providerAccount.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColorLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          if (phoneTextEditingController?.text.isEmpty ?? true) {
                            Fluttertoast.showToast(msg: "Please provide valid phone number!");
                            return;
                          }
                          providerAccount.sentOtpCode(
                            phoneNumber: "$_initialCountryCode${phoneTextEditingController?.text}",
                          );
                        },
                        child: Text(
                          LanguageKey.continueText.tr,
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
