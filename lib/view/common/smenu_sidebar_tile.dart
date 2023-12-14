import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';

class SidemenuTile extends StatefulWidget {
  @override
  _SidemenuTileState createState() => _SidemenuTileState();
}

class _SidemenuTileState extends State<SidemenuTile> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
        buildSectionHeader("History"),
        buildListTile(5, Icons.history, 'History'),
        buildDivider(),
        buildListTile(6, Icons.notifications_active_sharp, 'Notifications'),
        buildDivider(),
      ],
    );
  }

  Widget buildListTile(int index, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        // Add your logic here for the selected item
      },
      child: AnimatedContainer(
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

