import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_mobile_app/controllers/zoom_provider.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:job_mobile_app/view/ui/drawer/drawer_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/drawer_screen.dart';
import 'package:provider/provider.dart';


class Main_Screen extends StatefulWidget {
  const Main_Screen({Key? key}) : super(key: key);

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Zoom_Notifier>(
      builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
          menuScreen: Drawer_Screen(
            indexSetter: (index) {
              zoomNotifier.currentIndex = index;
            },
          ),
          mainScreen: currentScreen(zoomNotifier),
          borderRadius: 30,
          showShadow: true,
          angle: 0.0,
          slideWidth: 250,
          menuBackgroundColor: Color(kLightBlue.value),
        );
      },
    );
  }

  Widget currentScreen(Zoom_Notifier zoomNotifier) {
    switch (zoomNotifier.currentIndex) {
      case 0:
        return drawer_animated();
      case 1:
        return Home_Screen();
      case 2:
        return Home_Screen();
      case 3:
        return Home_Screen();
      case 4:
        return Home_Screen();
      default:
        return Home_Screen();
    }
  }
}
