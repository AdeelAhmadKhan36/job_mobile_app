import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/ui/admin_panel/applications.dart';

class SelectJobScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Job',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(kprimary_colors.value),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users_Jobs')
                    .where('applicationReceived', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                          'Error: ${snapshot.error.toString()}',
                        ));
                  }

                  QuerySnapshot? querySnapshot = snapshot.data;
                  List<DocumentSnapshot>? jobDocs = querySnapshot?.docs;

                  if (jobDocs == null || jobDocs.isEmpty) {
                    return Center(child: Text('No jobs available'));
                  }

                  return ListView.builder(
                    itemCount: jobDocs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot jobDoc = jobDocs[index];
                      String jobTitle = jobDoc['jobTitle'];
                      String applicationsStatus =
                          jobDoc['applicationsStatus'] ?? 'submitted';

                      IconData iconData;
                      if (applicationsStatus == 'Accepted') {
                        iconData = Icons.check_circle;
                      } else if (applicationsStatus == 'Rejected') {
                        iconData = Icons.cancel;
                      } else {
                        iconData = Icons.arrow_forward_ios_rounded;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(klightGrey.value),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.work, size: 30),
                                    SizedBox(width: 20),
                                    Text(
                                      jobTitle,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Color(kLight.value),
                                  child: Icon(
                                    iconData,
                                    color: applicationsStatus == 'Accepted'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              if (applicationsStatus == 'submitted') {
                                Get.to(JobApplicationsScreen(jobId: jobDoc.id));
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
