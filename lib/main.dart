import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/controllers/SignUp_Provider.dart';
import 'package:job_mobile_app/controllers/login_provider.dart';
import 'package:job_mobile_app/controllers/on_boarding_providers.dart';
import 'package:job_mobile_app/controllers/zoom_provider.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/view/ui/Main_Screen.dart';
import 'package:job_mobile_app/view/ui/Splash_Screen.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:job_mobile_app/view/ui/auth/login_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/drawer_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/side_manu.dart';
import 'package:job_mobile_app/view/ui/on_boarding_screen/page_three.dart';
import 'package:job_mobile_app/view/ui/drawer/hamda_drawer.dart';
import 'package:provider/provider.dart';

import 'view/ui/on_boarding_screen/onboarding_screen.dart';
import 'view/ui/on_boarding_screen/page_one.dart';
import 'view/ui/on_boarding_screen/page_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider (create: (_)=>onBoard_Notifier()),
          ChangeNotifierProvider (create: (_)=>LoginNotifier()),
          ChangeNotifierProvider (create: (_)=>SignUpNotifier()),
          ChangeNotifierProvider (create: (_)=>Zoom_Notifier()),
        ],

        child: const GetMaterialApp(
          debugShowCheckedModeBanner:false,
        // home: Splash_Screen(),
        // home: Drawer_Menu(),
        // home: DrawerAnimated(),
        // home: drawer_animated(),
          home: Main_Screen(),




    )

    );
  }
}
