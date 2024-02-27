import 'package:flutter/material.dart';
import 'package:job_mobile_app/controllers/Home_Provider.dart';
import 'package:job_mobile_app/controllers/Notification_provider.dart';
import 'package:job_mobile_app/controllers/bokmark_provider.dart';
import 'package:job_mobile_app/controllers/chat_provider.dart';
import 'package:job_mobile_app/controllers/device_managment.dart';
import 'package:job_mobile_app/controllers/history_provider.dart';
import 'package:job_mobile_app/controllers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/ui/auth/profile.dart';


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
            buildListTile(1, Icons.chat_bubble_outline, 'Chat'),
            buildDivider(),
            buildListTile(2, Icons.bookmark_add_outlined, 'Bookmarks'),
            buildDivider(),
            buildListTile(3, Icons.devices, 'Device Management'),
            buildDivider(),
            buildListTile(4, Icons.supervised_user_circle_rounded, 'Profile'),
            buildDivider(),
            // buildSectionHeader("History"),
            // buildListTile(5, Icons.history, 'History'),
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

  Widget buildListTile(int index, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        _onTileTap(index);
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
                          Navigator.of(context).pushReplacementNamed('/chat');
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

