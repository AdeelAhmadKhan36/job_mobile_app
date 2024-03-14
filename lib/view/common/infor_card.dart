import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatefulWidget {
  final String name, profession;


  const InfoCard({
    Key? key,
    required this.name,
    required this.profession,
  }) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
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

  Widget build(BuildContext context) {
    return   StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).collection('User_Profile').snapshots(),
        builder:(context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const CircularProgressIndicator();
        }if(snapshot.hasError){

         return Text('Error: ${snapshot.error}');
        }

        final documents = snapshot.data!.docs;
        userData = documents.first.data()
        as Map<String, dynamic>;

        return  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              // Use a placeholder image from assets or a default image URL here
              backgroundImage: userData?['profileImageUrl'] != null
                  ? NetworkImage(userData?['profileImageUrl']!)
                  : const AssetImage('Assets/Images/profile.png') as ImageProvider, // Use default from assets if URL not available
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.profession,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );

        }

    );






  }
}
