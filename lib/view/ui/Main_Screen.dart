import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_mobile_app/controllers/zoom_provider.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/smenu_sidebar_tile.dart';
import 'package:job_mobile_app/view/ui/Profile/admin_profile.dart';
import 'package:job_mobile_app/view/ui/Profile/profile_details.dart';
import 'package:job_mobile_app/view/ui/Splash_Screen.dart';
import 'package:job_mobile_app/view/ui/admin_panel/admin_drawer.dart';
import 'package:job_mobile_app/view/ui/admin_panel/admin_home.dart';
import 'package:job_mobile_app/view/ui/admin_panel/post_job.dart';
import 'package:job_mobile_app/view/ui/auth/login_screen.dart';
import 'package:job_mobile_app/view/ui/auth/usersignup_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:job_mobile_app/view/ui/drawer/drawer_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/drawer_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/side_manu.dart';
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
            // Drawer_Menu(), // Drawer menu goes at the bottom
            currentScreen(zoomNotifier), // Current screen overlay
          ],
        );
      },
    );
  }

  Widget currentScreen(Zoom_Notifier zoomNotifier) {
    switch (zoomNotifier.currentIndex) {
      case 0:

         return OnBoarding_Screen();
         //  return drawer_animated();

        //  return EmployerDashboard();
        //   return JobPostScreen();
        // return Home_Screen();
        // return UserSignUp_Screen();
        // return admin_main_page();
        // return Profile_Details();

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
