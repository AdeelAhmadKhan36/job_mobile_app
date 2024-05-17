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

    // Fetch total accepted applications
    QuerySnapshot acceptedApplicationsSnapshot = await FirebaseFirestore
        .instance
        .collection('Admins')
        .doc(adminId)
        .collection('Job_Applications')
        .where('status', isEqualTo: 'accepted')
        .get();

    setState(() {
      totalAcceptedApplications = acceptedApplicationsSnapshot.size;
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
      ),
      body: totalJobs == 0 &&
          totalApplications == 0 &&
          totalAcceptedApplications == 0
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total Jobs: $totalJobs'),
            Text('Total Applications: $totalApplications'),
            Text(
                'Total Accepted Applications: $totalAcceptedApplications'),
            SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: totalJobs.toDouble(),
                      title: 'Jobs',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: totalApplications.toDouble(),
                      title: 'Applications',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: totalAcceptedApplications.toDouble(),
                      title: 'Accepted',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
