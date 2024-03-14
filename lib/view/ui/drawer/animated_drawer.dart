import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  late User currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser!;
    print('Current User UID: ${currentUser.uid}');
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
                    // InfoCard Widget to display user information
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(currentUser.uid)
                          .collection('User_Profile')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Text('No data available');
                        }

                        final documents = snapshot.data!.docs;
                        userData = documents.first.data()
                        as Map<String, dynamic>;                 // Update userData here
                        // print('Here is your data: $userData');

                        return InfoCard(
                          name: userData?['User Name'] ?? 'Default',
                          profession:
                              userData?['Your Expertise'] ?? 'Your Expertise',
                        );
                      },
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
                  ..setEntry(0, 3, 210 * val)
                  ..rotateY((pi / 6) * val),
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Custom_AppBar(
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: CircleAvatar(
                            radius: 25,
                            // Use a placeholder image from assets or a default image URL here
                            backgroundImage: userData?['profileImageUrl'] != null
                                ? NetworkImage(userData?['profileImageUrl']!)
                                : const AssetImage('Assets/Images/profile.png') as ImageProvider, // Use default from assets if URL not available
                          ),

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
                            child: const Icon(Icons.menu_rounded, weight: 50),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: const Center(child: Home_Screen()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
