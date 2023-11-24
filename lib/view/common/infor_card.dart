import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class InfoCard extends StatelessWidget {
  final String name,profession;
  const InfoCard({
    super.key, required this.name, required this.profession,
  });


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white24,
        child: Icon(Icons.person,weight:20,color: Colors.white),
      ),
      title: Text(name,style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
      subtitle: Text(profession,style:TextStyle(color: Colors.white,)),

    );
  }
}