import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  bool Shake = true;

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/'));

    return Scaffold(
      body: Center(
        child: ShakeAnimatedWidget(
          enabled: Shake,
          duration: Duration(milliseconds: 1500),
          shakeAngle: Rotation.deg(z: 10),
          curve: Curves.linear,
          child: Image(
            image: AssetImage('assets/images/Freshy1.png'),
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
