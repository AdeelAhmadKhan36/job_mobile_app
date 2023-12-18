import 'package:flutter/material.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
    child: Custom_AppBar(
    text: "Profile",
    child:  Column(
      children: [
        MaterialButton(
            onPressed: () {
              setState(() {
                value== 0 ? value = 1 : value = 0;
              });
            },
            child: Icon(Icons.menu_rounded,weight:50,color: Colors.red,)
        )
      ],
    ),

    ),


    ));
  }
}
