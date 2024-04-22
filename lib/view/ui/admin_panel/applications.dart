import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/view/ui/admin_panel/applicant_Profile.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';

class JobApplicationsScreen extends StatelessWidget {
  final String jobId;

  const JobApplicationsScreen({Key? key, required this.jobId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Applications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(kprimary_colors.value),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchJobDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Job details not found'));
          }

          Map<String, dynamic> jobData =
          snapshot.data!.data() as Map<String, dynamic>;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Admins')
                .doc(FirebaseAuth.instance.currentUser!.uid) // Current user's UID
                .collection('Job_Applications')
                .where('jobID', isEqualTo: jobId)
                .where('status', isEqualTo: 'submitted')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error.toString()}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No applications found'));
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot applicationDoc = snapshot.data!.docs[index];
                  String applicantUid = applicationDoc['applicantUID'];

                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(applicantUid)
                        .get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return ListTile(
                          title: Text('Loading...'),
                        );
                      }

                      if (userSnapshot.hasError) {
                        return ListTile(
                          title: Text('Error: ${userSnapshot.error.toString()}'),
                        );
                      }

                      if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                        return ListTile(
                          title: Text('User details not found'),
                        );
                      }

                      Map<String, dynamic> userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                      String username = userData['name'];

                      return Padding(
                        padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(klightGrey.value),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  'Applicant:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5,),
                                Text('$username'),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text('Job Title:',style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(width: 20,),
                                Flexible(child: Text(' ${jobData['jobTitle']}')),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Get.to(Applicant_Profile(
                                    applicantUid: applicantUid,
                                  jobId:jobId,));
                              },
                              child: Text('View Profile'),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<DocumentSnapshot> _fetchJobDetails() async {
    try {
      return await FirebaseFirestore.instance
          .collection('Jobs')
          .doc(jobId)
          .get();
    } catch (e) {
      print('Failed to fetch job details: $e');
      throw Exception('Failed to fetch job details: $e');
    }
  }
}
