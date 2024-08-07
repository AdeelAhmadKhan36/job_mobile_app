import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_mobile_app/controllers/Home_Provider.dart';
import 'package:job_mobile_app/controllers/Notification_provider.dart';
import 'package:job_mobile_app/controllers/bokmark_provider.dart';
import 'package:job_mobile_app/controllers/chat_provider.dart';
import 'package:job_mobile_app/controllers/device_managment.dart';
import 'package:job_mobile_app/controllers/history_provider.dart';
import 'package:job_mobile_app/controllers/profile_provider.dart';
import 'package:job_mobile_app/utils/utils.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:provider/provider.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/ui/Profile/profile.dart';


class SidemenuTile extends StatefulWidget {
  @override
  _SidemenuTileState createState() => _SidemenuTileState();
}

class _SidemenuTileState extends State<SidemenuTile> {
  int selectedIndex = -1; // Initialize with -1 to indicate no selection

  @override
  Widget build(BuildContext context) {
    return Consumer<Profile_Notifier>(
      builder: (context, profileNotifier, child) {
        return Column(
          children: [
            buildListTile(0, Icons.home, 'Home'),
            buildDivider(),
            buildListTile(1, Icons.chat_bubble_outline, 'Applications'),
            buildDivider(),
            buildListTile(2, Icons.bookmark_add_outlined, 'Bookmarks'),
            buildDivider(),
            buildListTile(3, Icons.devices, 'Device Management'),
            buildDivider(),
            buildListTile(4, Icons.supervised_user_circle_rounded, 'Profile'),
            buildDivider(),
            buildListTile(5, Icons.notifications_active_sharp, 'Notifications'),
            buildDivider(),
            buildListTile(6, Icons.logout, 'Logout'),
            buildDivider(),
          ],
        );
      },
    );
  }

  void _onTileTap(int index) {
    setState(() {
      // Toggle the selected index on tap
      selectedIndex = selectedIndex == index ? -1 : index;
    });
  }

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

  Future<bool> isAdmin() async {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if the user exists and has the 'isAdmin' custom claim set to true
    if (currentUser != null && currentUser.uid != null) {
      final tokenResult = await currentUser.getIdTokenResult();
      return tokenResult.claims?['isAdmin'] ?? false;
    }

    // Return false if user is null or UID is null
    return false;
  }

  Widget buildListTile(int index, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        _onTileTap(index);
        if (index == 6) {
          // Perform logout
          _logout();
        }
      },
      child: Container(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Color(kblue.value) : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListTile(
                leading: SizedBox(
                  child: Icon(icon, color: Colors.white, size: 30),
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (selectedIndex == index)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the corresponding page based on the selected index
                      switch (index) {
                        case 0:
                          Navigator.of(context).pushReplacementNamed('/');
                          break;
                        case 1:
                          Navigator.of(context).pushReplacementNamed('/application');
                          break;
                        case 2:
                          Navigator.of(context).pushReplacementNamed('/bookmarks');
                          break;
                        case 3:
                          Navigator.of(context).pushReplacementNamed('/device_management');
                          break;
                        case 4:
                          Navigator.of(context).pushReplacementNamed('/profile');
                          break;
                        case 5:
                          Navigator.of(context).pushReplacementNamed('/notifications');
                          break;
                        case 6:
                          Navigator.of(context).pushReplacementNamed('/logout');
                          _logout();
                          break;
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 30, bottom: 16),
      child: Row(
        children: [
          Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Divider(height: 20, color: Colors.white24);
  }
}
