import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/infor_card.dart';
import 'package:job_mobile_app/view/common/smenu_sidebar_tile.dart';
import 'package:rive/rive.dart';
class Drawer_Menu extends StatefulWidget {
  const Drawer_Menu({super.key});

  @override
  State<Drawer_Menu> createState() => _Drawer_MenuState();
}

class _Drawer_MenuState extends State<Drawer_Menu> {
  final controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 280,
        height: double.infinity,
        color: Color(kdrawer.value),
        child: SafeArea(
          child: Column(
            children: [
              InfoCard(
                name: 'Adeel Ahmad',
                profession: 'Flutter Developer',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0,top: 30,bottom: 16,right: 170),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),




                  )
                ),

              SidemenuTile(),





            ],
          ),
        ),

      ),

    );
  }
}


class List_Item extends StatelessWidget {
  final icon;
  final String title;
  

  const List_Item({
    super.key, this.icon, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 34,
        width: 34,
        child:Icon(icon,color: Colors.white,),
        ),
      title: Text(
        title,style: TextStyle(color: Colors.white),),
    );
  }
}



