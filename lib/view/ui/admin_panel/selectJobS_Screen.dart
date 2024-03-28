
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/ui/admin_panel/applications.dart';

class SelectJobScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch jobs with applicationReceived: true and display job titles
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Job',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(kprimary_colors.value),
        centerTitle: true,
        leading: IconButton(onPressed:(){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SafeArea(
        child: Column(
          children: [
        
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: _fetchJobsWithApplications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
              
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error.toString()}'));
                  }
              
                  List<DocumentSnapshot>? jobDocs = snapshot.data;
              
                  if (jobDocs == null || jobDocs.isEmpty) {
                    return Center(child: Text('No jobs available'));
                  }
              
                  return ListView.builder(
                    itemCount: jobDocs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot jobDoc = jobDocs[index];
                      String jobTitle = jobDoc['jobTitle'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 30,left: 20,right: 10),
                        child: Container(
              
                          decoration: BoxDecoration(
                              color: Color(klightGrey.value),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.work,size: 30,),
                                    SizedBox(width: 20,),
                                    Text(jobTitle,style:TextStyle(fontWeight:FontWeight.bold),),
              
                                  ],
                                ),
              
                                GestureDetector(
                                  onTap: () {
              
                                    Get.to(JobApplicationsScreen(jobId: jobDoc.id));
              
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
                              ],
                            ),
              
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

  Future<List<DocumentSnapshot>> _fetchJobsWithApplications() async {
    // Fetch jobs where applicationReceived is true
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Jobs')
        .where('applicationReceived', isEqualTo: true)
        .get();
    List<DocumentSnapshot> jobDocs = querySnapshot.docs;
    return jobDocs;
  }
}
