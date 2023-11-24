
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
class Drawer_Widget extends StatelessWidget {
  const Drawer_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ZoomDrawer.of(context)!.toggle();
      },
      child: Ink.image(
          image: AssetImage("Assets/Images/menu_icon.png"),
        width: 50,
        height: 50,
      ),
    );
  }
}
