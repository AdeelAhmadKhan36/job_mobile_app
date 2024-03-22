import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/view/ui/History_Page.dart';
import 'package:job_mobile_app/view/ui/Main_Screen.dart';
import 'package:job_mobile_app/view/ui/Notification_Page.dart';
import 'package:job_mobile_app/view/ui/Splash_Screen.dart';
import 'package:job_mobile_app/view/ui/Profile/profile.dart';
import 'package:job_mobile_app/view/ui/bookmark/BookMarkPage.dart';
import 'package:job_mobile_app/view/ui/chat/chat_screen.dart';
import 'package:job_mobile_app/view/ui/device_manag/device_Managment_Page.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:job_mobile_app/view/ui/auth/login_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/drawer_screen.dart';
import 'package:job_mobile_app/view/ui/drawer/side_manu.dart';
import 'package:job_mobile_app/view/ui/on_boarding_screen/page_three.dart';
import 'package:job_mobile_app/view/ui/on_boarding_screen/onboarding_screen.dart';
import 'package:job_mobile_app/view/ui/on_boarding_screen/page_one.dart';
import 'package:job_mobile_app/view/ui/on_boarding_screen/page_two.dart';
import 'package:job_mobile_app/controllers/Home_Provider.dart';
import 'package:job_mobile_app/controllers/Notification_provider.dart';
import 'package:job_mobile_app/controllers/SignUp_Provider.dart';
import 'package:job_mobile_app/controllers/bokmark_provider.dart';
import 'package:job_mobile_app/controllers/chat_provider.dart';
import 'package:job_mobile_app/controllers/device_managment.dart';
import 'package:job_mobile_app/controllers/history_provider.dart';
import 'package:job_mobile_app/controllers/login_provider.dart';
import 'package:job_mobile_app/controllers/on_boarding_providers.dart';
import 'package:job_mobile_app/controllers/profile_provider.dart';
import 'package:job_mobile_app/controllers/profile_updateProvider.dart';
import 'package:job_mobile_app/controllers/zoom_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).catchError((error) {
    print("Error initializing Firebase: $error");
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => onBoard_Notifier()),
        ChangeNotifierProvider(create: (_) => loginNotifier()),
        ChangeNotifierProvider(create: (_) => SignUpNotifier()),
        ChangeNotifierProvider(create: (_) => Zoom_Notifier()),
        ChangeNotifierProvider(create: (_) => Profile_Notifier()),
        ChangeNotifierProvider(create: (_) => Home_Notifier()),
        ChangeNotifierProvider(create: (_) => Chat_Notifier()),
        ChangeNotifierProvider(create: (_) => Bookmark_Notifier()),
        ChangeNotifierProvider(create: (_) => Device_Managment()),
        ChangeNotifierProvider(create: (_) => History_Notifier()),
        ChangeNotifierProvider(create: (_) => Notification_Notifier()),
        ChangeNotifierProvider(create: (_) => changeprofileNotifier()),
      ],
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => Main_Screen(),
              '/chat': (context) => Chat_Screen(),
              '/bookmarks': (context) => BookMark_Screen(),
              '/device_management': (context) => device_Managment_Page(),
              '/profile': (context) => Profile_Page(),
              '/history': (context) => Hoistory_Screen(),
              '/notifications': (context) => Notification_screen(),
              '/logout': (context) => drawer_animated(),
            },
          );
        },
      ),
    );
  }
}
