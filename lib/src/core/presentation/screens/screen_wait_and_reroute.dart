import 'package:flutter/material.dart';

class ScreenWaitAndReRoute extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final String route;

  const ScreenWaitAndReRoute({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    required this.route,
  });

  @override
  State<ScreenWaitAndReRoute> createState() => _ScreenWaitAndReRouteState();
}

class _ScreenWaitAndReRouteState extends State<ScreenWaitAndReRoute> {
  @override
  void initState() {
    Future.delayed(widget.duration).then((value) {
      //route to next page
      Navigator.pushNamedAndRemoveUntil(
        context,
        widget.route,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
