import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/controllers/login_provider.dart';
import 'package:job_mobile_app/controllers/on_boarding_providers.dart';
import 'package:job_mobile_app/controllers/zoom_provider.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/ui/device_manag/Device_info.dart';
import 'package:job_mobile_app/view/ui/on_boarding_screen/onboarding_screen.dart';
import 'package:provider/provider.dart';

class device_Managment_Page extends StatefulWidget {
  const device_Managment_Page({super.key});

  @override
  State<device_Managment_Page> createState() => _device_Managment_PageState();
}

class _device_Managment_PageState extends State<device_Managment_Page> {
  @override
  Widget build(BuildContext context) {
    var zoomNotfier=Provider.of<Zoom_Notifier>(context);
    var onBoardNotfier=Provider.of<onBoard_Notifier>(context);
    String date = DateTime.now().toString();
    var loginDate = date.substring(0, 11);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
                color: Color(kprimary_colors.value),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child:
                Custom_AppBar(text: "Device Managment", child: DrawerButton()),
          ),
        ),
        body: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "You are looged in to your account on these devices",
                    style: TextStyle(
                        color: Color(kDark.value),
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Device_Info(
                    date: loginDate,
                    device: 'HP EliteBook',
                    ipAdress: '10.0.14.000',
                    platform: 'Google Chrome',
                    location: 'Mansehra KPK Pakistan',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Device_Info(
                    date: loginDate,
                    device: 'Infinix Hot 11 Play',
                    ipAdress: '10.0.19.000',
                    platform: 'Google',
                    location: 'Mansehra KPK Pakistan',
                  ),
                ],
              ),
            ),
            Consumer<LoginNotifier>
              (builder:(context, LoginNotifier,child){
                return GestureDetector(
                  onTap: (){
                    zoomNotfier.currentIndex=0;
                    onBoardNotfier.isLastPage=false;
                    Get.to(()=>OnBoarding_Screen());
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text("Sign Out of all devices",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(kOrange.value),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                );

            })
          ]),
        ));
  }
}
