import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
            ),
            Text("Welcome to Home"),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
            ),
            BasicButton(
              buttonText: "Logout",
              width: 200,
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false,);
              },
            ),
          ],
        ),
      ),
    );
  }
}
