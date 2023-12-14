
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:rive/rive.dart';
class Menu_button extends StatelessWidget {

  const Menu_button({super.key,
    required this.press,
    required this.riveonInit});
   final VoidCallback press;
   final ValueChanged<Artboard> riveonInit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Ink.image(
          image: AssetImage("Assets/Images/menu_icon.png"),

        width: 80,
        height: 80,
      ),
    );
  }
}
