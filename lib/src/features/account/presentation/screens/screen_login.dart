import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String _initialCountryCode = "+91";
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
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img1.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
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
                      style: TextStyle(fontSize: 33, color: Colors.grey),
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
                          hintText: "Phone",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<ProviderAccount>(builder: (_, providerAccount, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: providerAccount.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade600,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
                            "Send the code",
                          ),
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
