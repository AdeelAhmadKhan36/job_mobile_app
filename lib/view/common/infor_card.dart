
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late User? currentUser;
  Map<String, dynamic>? userData;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      debugPrint('Current User UID: ${currentUser!.uid}');
      checkUserRole();
    } else {
      debugPrint('User not logged in');
    }
  }

  Future<void> checkUserRole() async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .get();

    final adminSnapshot = await FirebaseFirestore.instance
        .collection('Admins')
        .doc(currentUser!.uid)
        .get();

    setState(() {
      _isAdmin = adminSnapshot.exists;
    });

    if (userSnapshot.exists) {
      // User profile exists
      setState(() {
        _isAdmin = false;
        userData = userSnapshot.data() as Map<String, dynamic>;
      });
    } else if (adminSnapshot.exists) {
      // Admin profile exists
      setState(() {
        _isAdmin = true;
        userData = adminSnapshot.data() as Map<String, dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: currentUser != null && !_isAdmin
          ? FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .collection('User_Profile')
          .snapshots()
          : null, // Pass null if currentUser is null or admin
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                // Use a placeholder image from assets or a default image URL here
                backgroundImage: AssetImage('Assets/Images/profile.png'),
              ),
            ]
          );
        }

        final documents = snapshot.data!.docs;
        userData = documents.first.data() as Map<String, dynamic>;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              // Use a placeholder image from assets or a default image URL here
              backgroundImage: userData?['profileImageUrl'] != null
                  ? NetworkImage(userData?['profileImageUrl']!)
                  : const AssetImage('Assets/Images/profile.png') as ImageProvider<Object>, // Explicitly cast AssetImage to ImageProvider<Object>
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isAdmin ? (userData?['name'] ?? 'Default Name') : (userData?['User Name'] ?? 'Default Name'),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isAdmin ? (userData?['email'] ?? 'Default Email') : (userData?['Your Expertise'] ?? 'Default Profession'),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}



