import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/Jobs/Jobs_page.dart';

class RecentViewAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View All Recent Jobs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(kmycolor.value),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Jobs')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var jobs = snapshot.data?.docs;

          if (jobs == null || jobs.isEmpty) {
            return Center(child: Text('No jobs available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                var job = jobs[index];
                var jobData = job.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 140,
                    width: double.infinity,
                    color: Color(klightGrey.value),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(jobData['imageUrl']),
                            ),
                            SizedBox(width: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Heading(
                                      text: jobData['companyName'],
                                      color: Color(kDark.value),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        jobData['jobTitle'],
                                        style: TextStyle(
                                          color: Color(kDarkGrey.value),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),

                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50,bottom: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => Job_Page(
                                        title: jobData['companyName'],
                                        id: job.id,
                                      ));
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
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Heading(
                            text: "${jobData['salary']}/ Month",
                            color: Color(kDark.value),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
