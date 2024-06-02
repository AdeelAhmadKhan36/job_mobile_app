
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/utils/utils.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/infor_card.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/common/smenu_sidebar_tile.dart';
import 'package:job_mobile_app/view/ui/admin_panel/admin_home.dart';

import '../drawer/animated_drawer.dart';

class admin_main_page extends StatefulWidget {
  const admin_main_page({Key? key,}) : super(key: key);

  @override
  _admin_main_pageState createState() => _admin_main_pageState();
}

class _admin_main_pageState extends State<admin_main_page> {
  double value = 0;

  void _logout() async {
    try {
      // Get the current user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the device info documents for both user and admin
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users/$uid/user_logins')
          .get();

      QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Admins/$uid/admin_logins')
          .get();

      // Delete the documents from the 'user_logins' subcollection
      userSnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      // Delete the documents from the 'admin_logins' subcollection
      adminSnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      // Sign out the user
      await FirebaseAuth.instance.signOut();
      Get.off(drawer_animated());
      Utils().toastMessage('Logout Successful');
    } catch (e) {
      print('Error signing out: $e');
      Utils().toastMessage('Error signing out');
    }
  }

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
              width: 230,
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      name: '',
                      profession: '',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 30,
                        bottom: 16,
                      ),
                      child: Text(
                        "Admin Profile".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),

                    ),

                     Divider(

                         height: 20, color: Colors.white24,thickness: 5,
                     ),
                      SizedBox(height: 30,),

                      GestureDetector(
                        onTap: (){
                          _logout();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.logout,size: 30,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text('Logout',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                          ],
                        ),
                      )


                      // SidemenuTile(),
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
                  ..setEntry(0, 3, 210 * val)
                  ..rotateY((pi / 6) * val),
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Container(
                      color: Color(kDarkBlue.value),
                      child: Custom_AppBar(
                        title: Heading(
                          text: "My Dashbaord",
                          color: Color(kLight.value),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.notifications_active, size: 30,color: Colors.white,),
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
                                  value == 0 ? value = 1 : value = 0;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Icon(Icons.menu_rounded, weight: 50, size: 30,color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: EmployerDashboard(), // No extra spacing between the app bar and body
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}



