import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../resources/constants/app_colors.dart';

class JobAnalytics extends StatefulWidget {
  final String? adminUID;

  const JobAnalytics({Key? key, this.adminUID}) : super(key: key);

  @override
  _JobAnalyticsState createState() => _JobAnalyticsState();
}

class _JobAnalyticsState extends State<JobAnalytics> {
  int totalJobs = 0;
  int totalApplications = 0;
  int totalAcceptedApplications = 0;
  int totalRejectedApplications = 0;
  int totalPendingApplications = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String adminId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch total jobs
    QuerySnapshot jobsSnapshot = await FirebaseFirestore.instance
        .collection('Admins')
        .doc(adminId)
        .collection('my_jobs')
        .get();

    setState(() {
      totalJobs = jobsSnapshot.size;
    });

    // Fetch total applications
    QuerySnapshot applicationsSnapshot = await FirebaseFirestore.instance
        .collection('Admins')
        .doc(adminId)
        .collection('Job_Applications')
        .get();

    setState(() {
      totalApplications = applicationsSnapshot.size;
    });

    // Fetch total accepted, rejected, and pending applications
    QuerySnapshot statusSnapshot = await FirebaseFirestore.instance
        .collection('Users_Jobs')
        .get();

    int accepted = 0;
    int rejected = 0;
    int pending = 0;

    for (var doc in statusSnapshot.docs) {
      String status = doc['applicationsStatus'];
      if (status == 'Accepted') {
        accepted++;
      } else if (status == 'Rejected') {
        rejected++;
      } else if (status == 'submitted') {
        pending++;
      }
    }

    setState(() {
      totalAcceptedApplications = accepted;
      totalRejectedApplications = rejected;
      totalPendingApplications = pending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Analytics',
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
      body: totalJobs == 0 &&
          totalApplications == 0 &&
          totalAcceptedApplications == 0 &&
          totalRejectedApplications == 0 &&
          totalPendingApplications == 0
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total Jobs: $totalJobs'),
            Text('Total Applications: $totalApplications'),
            Text('Total Accepted Applications: $totalAcceptedApplications'),
            Text('Total Rejected Applications: $totalRejectedApplications'),
            Text('Total Pending Applications: $totalPendingApplications'),
            SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: totalJobs.toDouble(),
                      title: 'Jobs',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: totalApplications.toDouble(),
                      title: 'Applications',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: totalAcceptedApplications.toDouble(),
                      title: 'Accepted',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: totalRejectedApplications.toDouble(),
                      title: 'Rejected',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.yellow,
                      value: totalPendingApplications.toDouble(),
                      title: 'Pending',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
