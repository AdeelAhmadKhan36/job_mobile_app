import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/infor_card.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/common/smenu_sidebar_tile.dart';
import 'package:job_mobile_app/view/ui/admin_panel/admin_home.dart';

class admin_main_page extends StatefulWidget {
  const admin_main_page({Key? key}) : super(key: key);

  @override
  _admin_main_pageState createState() => _admin_main_pageState();
}

class _admin_main_pageState extends State<admin_main_page> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Drawer
          SafeArea(
            child: Container(
              width:230,
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      name: 'Adeel Ahmad',
                      profession: 'Flutter Developer',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 30,
                        bottom: 16,
                      ),
                      child: Text(
                        "Browse".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SidemenuTile(),
                  ],
                ),
              ),
            ),
          ),

          // Main Screen
          TweenAnimationBuilder(
            curve: Curves.easeInOut,
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 500),
            builder: (_, double val, __) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3,210 * val)
                  ..rotateY((pi / 6) * val),
                child: Scaffold(
                  appBar: PreferredSize(preferredSize:Size.fromHeight(50),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2,left: 2,right: 2),
                        child: Custom_AppBar(

                          title: Heading(
                              text: "Job Portal",
                              color: Color(kDark.value),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),

                          actions: [
                            IconButton(
                              icon: const Icon(Icons.notifications_active, size: 30),
                              onPressed: () {
                                // Handle search icon press
                              },
                            ),

                          ],
                          child: Column(
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      value== 0 ? value = 1 : value = 0;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Icon(Icons.menu_rounded,weight:50,size: 30,),
                                  )
                              )
                            ],
                          ),

                        ),
                      )),


                  body: Center(
                      child: EmployerDashboard()

                    // Home_Screen()
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
