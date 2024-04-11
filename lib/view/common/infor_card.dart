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
    } else if (_isAdmin) {
      // Admin profile exists
      setState(() {
        userData = {}; // Clear existing user data
      });

      // Fetch admin profile data from Admin_Profile subcollection
      final adminProfileSnapshot = await FirebaseFirestore.instance
          .collection('Admins')
          .doc(currentUser!.uid)
          .collection('Admin_Profile')
          .doc(currentUser!.uid)
          .get();

      if (adminProfileSnapshot.exists) {
        userData = adminProfileSnapshot.data() as Map<String, dynamic>;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: currentUser != null
          ? _isAdmin
          ? FirebaseFirestore.instance
          .collection('Admins')
          .doc(currentUser!.uid)
          .collection('Admin_Profile')
          .doc(currentUser!.uid)
          .snapshots()
          : FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .collection('User_Profile')
          .doc(currentUser!.uid)
          .snapshots()
          : null, // Pass null if currentUser is null
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !(snapshot.data!.exists)) {
          return const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  // Use a placeholder image from assets or a default image URL here
                  backgroundImage: AssetImage('Assets/Images/profile.png'),
                ),
              ]);
        }

        userData = snapshot.data!.data() as Map<String, dynamic>;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              // Use a placeholder image from assets or a default image URL here
              backgroundImage: userData?['profileImageUrl'] != null
                  ? NetworkImage(userData?['profileImageUrl']!)
                  : const AssetImage('Assets/Images/profile.png')
              as ImageProvider<Object>,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isAdmin
                      ? (userData?['name'] ?? 'Default Name')
                      : (userData?['User Name'] ?? 'Default Name'),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isAdmin
                      ? (userData?['email'] ?? 'Default Email')
                      : (userData?['Your Expertise'] ?? 'Default Profession'),
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
