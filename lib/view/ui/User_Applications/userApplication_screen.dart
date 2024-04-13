import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/Jobs/Jobs_page.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:job_mobile_app/view/ui/search/searchpage.dart';

class UserApplicationsScreen extends StatelessWidget {
  final String? userId;

  const UserApplicationsScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Applications',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(kmycolor.value),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.to(drawer_animated());
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('My_Applications')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var applications = snapshot.data?.docs;

          if (applications == null || applications.isEmpty) {
            return Center(
                child: Text(
              'No applications submitted yet.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: applications.map((application) {
                  var applicationData =
                      application.data() as Map<String, dynamic>;

                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Jobs')
                        .doc(applicationData['jobID'])
                        .get(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> jobSnapshot) {
                      if (jobSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (!jobSnapshot.hasData || !jobSnapshot.data!.exists) {
                        return SizedBox(); // Return an empty widget if job details are not available
                      }

                      var jobData =
                          jobSnapshot.data!.data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: Color(klightGrey.value),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(jobData['imageUrl']),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Heading(
                                          text: jobData['companyName'],
                                          color: Color(kDark.value),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            jobData['jobTitle'],
                                            style: TextStyle(
                                              color: Color(kDarkGrey.value),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (jobData['companyName'] != null &&
                                            applicationData['jobID'] != null) {
                                          Get.to(() => Job_Page(
                                                title: jobData['companyName']!,
                                                id: applicationData['jobID']!,
                                                showApplyButton: false,
                                              ));
                                        } else {
                                          // Handle the case when companyName or jobID is null
                                          // For example, you can show a toast message or navigate to a different page
                                          print(
                                              'Error: companyName or jobID is null');
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Color(kLight.value),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(kmycolor.value),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Heading(
                                  text: "Status: ${applicationData['status']}",
                                  color: Color(kDark.value),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
