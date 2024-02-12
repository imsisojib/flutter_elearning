import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/container_bg.dart';

class ScreenClassInvitation extends StatelessWidget{
  const ScreenClassInvitation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBg(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverCustomAppBar(title: "Invitation"),
          ],
        ),
      ),
    );
  }
}