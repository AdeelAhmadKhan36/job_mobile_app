import 'package:flutter/material.dart';
import 'package:job_mobile_app/controllers/zoom_provider.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/view/ui/on_boarding_screen/onboarding_screen.dart';
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
        return Stack(
          children: [
            currentScreen(zoomNotifier),
          ],
        );
      },
    );
  }

  Widget currentScreen(Zoom_Notifier zoomNotifier) {
    switch (zoomNotifier.currentIndex) {
      case 0:

         return OnBoarding_Screen();

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
