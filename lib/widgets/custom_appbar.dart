import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  List<Color> colorizeColors = [
    Colors.red,
    Color.fromARGB(255, 54, 216, 244),
    Colors.black,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 24.0,
    fontFamily: 'SF',
  );
  CustomAppBar({
    Key? key,
    required this.title,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: <Widget>[
              ShakeAnimatedWidget(
                enabled: automaticallyImplyLeading,
                duration: Duration(milliseconds: 1500),
                shakeAngle: Rotation.deg(z: 8),
                curve: Curves.linear,
                child: Image(
                  image: AssetImage('assets/images/Freshys.png'),
                  width: 50,
                  height: 50,
                ),
              ),
              Flexible(
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      title,
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                      speed: const Duration(milliseconds: 500),
                    ),
                  ],
                  pause: const Duration(milliseconds: 1000),
                  repeatForever: true,
                ),
              ),
            ],
          ),
        ),
      ),
      iconTheme: IconThemeData(color: Color.fromARGB(197, 0, 0, 0)),
      actions: [
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/wishlist',
            );
          },
        ),
      ],
    );
  }

  Size get preferredSize => Size.fromHeight(50.0);
}
