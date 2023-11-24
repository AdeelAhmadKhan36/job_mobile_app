import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_mobile_app/controllers/zoom_provider.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:provider/provider.dart';
class Drawer_Screen extends StatefulWidget {
  final ValueSetter indexSetter;

  const Drawer_Screen({super.key, required this.indexSetter});

  @override
  State<Drawer_Screen> createState() => _Drawer_ScreenState();
}

class _Drawer_ScreenState extends State<Drawer_Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Zoom_Notifier>(builder: (context,zoomNotifier,child){

      return GestureDetector(
        onDoubleTap:(){
          ZoomDrawer.of(context)!.toggle();
        } ,

        child: Scaffold(
          backgroundColor: Color(kLightBlue.value),
          body: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerItem(
                Icon(EvaIcons.menu),
                  "Home",
                  0,
                  zoomNotifier.currentIndex==0?
                  Color(kLight.value):
                  Color(klightGrey.value),
              ),
              drawerItem(
                Icon(EvaIcons.activityOutline),
                "Chat",
                1,
                zoomNotifier.currentIndex==0?
                Color(kLight.value):
                Color(klightGrey.value),
              ),
              drawerItem(
                Icon(EvaIcons.menu),
                "BookMark",
                2,
                zoomNotifier.currentIndex==0?
                Color(kLight.value):
                Color(klightGrey.value),
              ),
              drawerItem(
                Icon(EvaIcons.menu),
                "Device Mng",
                3,
                zoomNotifier.currentIndex==0?
                Color(kLight.value):
                Color(klightGrey.value),
              ),
              drawerItem(
                Icons.person,
                "Profile",
                5,
                zoomNotifier.currentIndex==0?
                Color(kLight.value):
                Color(klightGrey.value),
              ),
            ],
          ),



        ),
      );
    });
  }

  drawerItem(icon, text,index,color) {

  }
}
