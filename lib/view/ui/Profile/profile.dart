import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/resources/constants/app_constant.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  double value = 0;
  User? currentUser;
  Map<String, dynamic>? userData;
  List<String> skillKeys = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print('Current User UID: ${currentUser!.uid}');
      setState(() {});
    } else {
      print('User not logged in');
    }
  }

  String _getFileName(String? filePath) {
    if (filePath == null || filePath.isEmpty) {
      return ''; // Return empty string if filePath is null or empty
    } else {
      // Split the filePath by '?' to get the file name
      List<String> pathSegments = filePath.split('?');
      // Get the first segment after splitting by '?'
      String fileNameWithToken = pathSegments.first;
      // Split the fileNameWithToken by '/' to get the file name
      List<String> fileNameSegments = fileNameWithToken.split('/');
      // Decode the file name to remove any URL encoding
      String decodedFileName = Uri.decodeFull(fileNameSegments.last);
      // Return the decoded file name
      return decodedFileName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            color: Color(kprimary_colors.value),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Custom_AppBar(
            text: "Profile",
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      value == 0 ? value = 1 : value = 0;
                    });
                  },
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Handle back button press
                      Get.to(const drawer_animated());
                    },
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentUser != null)
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser!.uid)
                      .collection('User_Profile')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Text('No data available');
                    }

                    final documents = snapshot.data!.docs;
                    userData = documents.first.data() as Map<String, dynamic>?;
                    skillKeys = userData?.keys.where((key) => key.startsWith('Skill')).toList() ?? [];

                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                userData?['profileImageUrl'] ?? '',
                              ),
                            ),
                            const SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Heading(
                                  text: userData?['User Name'] ?? '',
                                  color: Color(kDark.value),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Color(kDark.value),
                                      size: 20,
                                    ),
                                    ReusableText(
                                      text: userData?['User Location'] ?? '',
                                      color: Color(kDarkGrey.value),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Container(
                          height: 150,
                          width: double.infinity,
                          color: Color(klightGrey.value),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 100,
                                    width: 80,
                                    color: Color(kLight.value),
                                    child: const Icon(
                                      Icons.picture_as_pdf_rounded,
                                      size: 70,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 35,
                                    left: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Heading(
                                        text: "Resume from JobPortal",
                                        color: Color(kDark.value),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      ReusableText(
                                        text: _getFileName(userData?['User CV']),
                                        color: Color(kDark.value),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Heading(
                                    text: "Edit",
                                    color: Color(kRed.value),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 60,
                          width: double.infinity,
                          color: Color(klightGrey.value),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  color: Color(kLight.value),
                                  child: const Icon(
                                    Icons.email_rounded,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Heading(
                                    text: userData?['User Email'] ?? '',
                                    color: Color(kDark.value),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 60,
                          width: double.infinity,
                          color: Color(klightGrey.value),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset("Assets/Images/pk.png"),
                                ),
                              ),
                              Heading(
                                text: userData?['User Phone'] ?? '',
                                color: Color(kDark.value),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 320,
                          width: double.infinity,
                          color: Color(klightGrey.value),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Heading(
                                  text: "Skills",
                                  color: Color(kDark.value),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  child: ListView.builder(
                                    itemCount: skillKeys.length,
                                    itemBuilder: (context, index) {
                                      String key = skillKeys[index];
                                      final skill = userData?[key] ?? '';
                                      return skill.isNotEmpty ? Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            skill,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ) : const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              else
                const Text('No User Available'),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile_Page()));
          },
          child: Container(
            height: 50,
            width: double.infinity,
            color: Color(kOrange.value),
            child: const Center(
              child: Text(
                "Submite Application",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
