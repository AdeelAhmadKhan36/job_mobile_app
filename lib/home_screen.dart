import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/screens/drawer/drawer_widget.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize:Size.fromHeight(50),

        child: Custom_AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(12),
              child: const CircleAvatar(
                radius: 15,
                backgroundImage:AssetImage("Assets/Images/dp.jpg") ,
              ),
            ),

          ],
          child: Padding(
            padding:EdgeInsets.all(12),
            child: Drawer_Widget(),
          ),
          
        )),
    );
  }
}
