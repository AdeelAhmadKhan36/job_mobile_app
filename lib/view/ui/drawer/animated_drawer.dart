import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/infor_card.dart';
import 'package:job_mobile_app/view/common/smenu_sidebar_tile.dart';

class drawer_animated extends StatefulWidget {
  const drawer_animated({Key? key}) : super(key: key);

  @override
  _drawer_animatedState createState() => _drawer_animatedState();
}

class _drawer_animatedState extends State<drawer_animated> {
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
              width: 200,
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
                      child: Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                value== 0 ? value = 1 : value = 0;
                              });
                            },
                            child: Icon(Icons.menu_rounded,weight:50,)
                          )
                        ],
                      ),

                    )),


                  body: Center(
                    child: Home_Screen()
                  ),
                ),
              );
            },
          ),

          // Gesture for Slide
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }
}
