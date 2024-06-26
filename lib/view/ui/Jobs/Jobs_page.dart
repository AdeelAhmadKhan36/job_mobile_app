import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/custom_outline_button.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/Profile/profile.dart';

import '../../Widgtes/requirements.dart';

class Job_Page extends StatefulWidget {
  const Job_Page({
    Key? key,
    required this.id,
    required this.title,
    this.showApplyButton = true, // Default value is true
  }) : super(key: key);

  final String id;
  final String title;
  final bool showApplyButton;

  @override
  State<Job_Page> createState() => _Job_PageState();
}

class _Job_PageState extends State<Job_Page> {
  bool isBookmarked = false;
  Map<String, dynamic>? jobData;
  String? adminUID;

  @override
  void initState() {
    super.initState();
    checkBookmarkStatus();
  }

  Future<void> checkBookmarkStatus() async {
    try {
      DocumentSnapshot bookmarkDoc = await FirebaseFirestore.instance
          .collection('bookmarks')
          .doc(widget.id)
          .get();

      setState(() {
        isBookmarked = bookmarkDoc.exists;
      });
    } catch (e) {
      print('Error checking bookmark status: $e');
    }
  }

  Future<void> toggleBookmark() async {
    CollectionReference bookmarksCollection =
    FirebaseFirestore.instance.collection('bookmarks');

    try {
      DocumentSnapshot bookmarkDoc = await FirebaseFirestore.instance
          .collection('bookmarks')
          .doc(widget.id)
          .get();

      if (bookmarkDoc.exists) {
        await FirebaseFirestore.instance
            .collection('bookmarks')
            .doc(widget.id)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Bookmark Removed Successfully'),
        ));
      } else {
        await FirebaseFirestore.instance
            .collection('bookmarks')
            .doc(widget.id)
            .set({
          'companyName': jobData!['companyName'],
          'imageUrl': jobData!['imageUrl'],
          'jobTitle': jobData!['jobTitle'],
          'jobLocation': jobData!['jobLocation'],
          'jobTiming': jobData!['jobTiming'],
          'salary': jobData!['salary'],
          'timestamp': FieldValue.serverTimestamp(),
          'popularity': 0,
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Bookmark Added Successfully'),
        ));
      }
    } catch (e) {
      print('Error toggling bookmark: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error Toggling Bookmark'),
      ));
    }

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  Future<void> fetchAdminUID() async {
    try {
      DocumentSnapshot jobDoc = await FirebaseFirestore.instance
          .collection('Jobs')
          .doc(widget.id)
          .get();

      setState(() {
        adminUID = jobDoc['adminUID'];
      });
    } catch (e) {
      print('Error fetching admin UID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Custom_AppBar(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back),
            ),
            title: Text(
              'Job Details',
              style: TextStyle(
                fontSize: 20,
                color: Color(kDark.value),
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    toggleBookmark();
                    print('Bookmark');
                  },
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Jobs')
            .doc(widget.id)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Error loading job details'));
          }

          jobData = snapshot.data!.data() as Map<String, dynamic>?;

          if (jobData == null) {
            return const Center(child: Text('Job details not found'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Color(klightGrey.value),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                            NetworkImage(jobData!['imageUrl'] ?? ''),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Heading(
                          text: jobData!['jobTitle'] ?? '',
                          color: Color(kDark.value),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        Text(
                          jobData!['jobLocation'] ?? '',
                          style: TextStyle(
                            color: Color(kDarkGrey.value),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 52, right: 52),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Custom_Button(
                                height: 30,
                                width: 85,
                                color2: Color(kLight.value),
                                text: jobData!['jobTiming'] ?? '',
                                color: Color(kOrange.value),
                              ),
                              Heading(
                                text: "${jobData!['salary'] ?? ''}/Month",
                                color: Color(kDark.value),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Heading(
                    text: "Job Description",
                    color: Color(kDark.value),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    jobData!['jobDescription'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(kDarkGrey.value),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Heading(
                    text: "Requirements",
                    color: Color(kDark.value),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  BulletPointsList(
                    points: (jobData!['jobRequirements'] is String)
                        ? (jobData!['jobRequirements'] as String)
                        .split('\n')
                        .map((line) => line.trim())
                        .toList()
                        : (jobData!['jobRequirements'] as List<dynamic>? ?? [])
                        .map((dynamic item) => item.toString())
                        .whereType<String>()
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: widget.showApplyButton
          ? Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: GestureDetector(
          onTap: () async {
            await fetchAdminUID();
            if (adminUID != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile_Page(
                    job: {'adminUID': adminUID, 'JobId': jobData},
                    jobID: widget.id,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Admin UID not found!'),
              ));
            }
          },
          child: Container(
            height: 50,
            width: double.infinity,
            color: Color(kOrange.value),
            child: const Center(
              child: Text(
                "Apply Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      )
          : null,
    );
  }
}
