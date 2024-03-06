import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/Widgtes/requirements.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/custom_outline_button.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/auth/profile.dart';

class Job_Page extends StatefulWidget {
  const Job_Page({Key? key, required this.id, required this.title}) : super(key: key);

  final String id;
  final String title;

  @override
  State<Job_Page> createState() => _Job_PageState();
}

class _Job_PageState extends State<Job_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Custom_AppBar(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back),
            ),
            title: Text(
              'Job Details',
              style: TextStyle(fontSize: 20, color: Color(kDark.value), fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.bookmark),
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Jobs').doc(widget.id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error loading job details'));
          }

          var job = snapshot.data!.data() as Map<String, dynamic>?;

          if (job == null) {
            return Center(child: Text('Job details not found'));
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
                            backgroundImage: NetworkImage(job['imageUrl'] ?? ''),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Heading(
                            text: job['jobTitle'] ?? '',
                            color: Color(kDark.value),
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                        Text(
                          job['jobLocation'] ?? '',
                          style: TextStyle(
                              color: Color(kDarkGrey.value),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
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
                                text: job['jobTiming'] ?? '',
                                color: Color(kOrange.value),
                              ),
                              Heading(
                                  text: "${job['salary'] ?? ''}/Month",
                                  color: Color(kDark.value),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Heading(
                      text: "Job Description",
                      color: Color(kDark.value),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 10),
                  Text(
                    job['jobDescription'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(kDarkGrey.value),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Heading(
                      text: "Requirements",
                      color: Color(kDark.value),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 10),
                  BulletPointsList(
                    points: (job['jobRequirements'] is String)
                        ? (job['jobRequirements'] as String).split('\n').map((line) => line.trim()).toList()
                        : (job['jobRequirements'] as List<dynamic>? ?? [])
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile_Page()));
          },
          child: Container(
            height: 50,
            width: double.infinity,
            color: Color(kOrange.value),
            child: Center(
              child: Text(
                "Apply Now",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
