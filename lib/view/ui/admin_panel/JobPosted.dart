import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_mobile_app/view/ui/admin_panel/applications.dart';
class SelectJobScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch all available job IDs and display them in a list
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Job'),
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchJobIds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          List<String>? jobIds = snapshot.data;

          if (jobIds == null || jobIds.isEmpty) {
            return Center(child: Text('No jobs available'));
          }

          return ListView.builder(
            itemCount: jobIds.length,
            itemBuilder: (context, index) {
              String jobId = jobIds[index];
              return ListTile(
                title: Text('Job ID: $jobId'),
                onTap: () {
                  Get.to(JobApplicationsScreen(jobId: jobId));
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<String>> _fetchJobIds() async {
    // Fetch all available job IDs
    // Implement your logic to fetch job IDs from Firestore or any other source
    // For example:
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Jobs').get();
    List<String> jobIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return jobIds;
  }
}
