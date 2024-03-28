import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';

class ViewAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Popular Jobs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(kmycolor.value),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Jobs')
            .orderBy('popularity', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var popularJobs = snapshot.data?.docs;

          if (popularJobs == null || popularJobs.isEmpty) {
            return Center(child: Text('No popular jobs available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: popularJobs.map((doc) {
                  var job = doc.data() as Map<String, dynamic>;
                  var jobId = doc.id; // Get the document ID

                  int currentPopularity = job['popularity'];
                  FirebaseFirestore.instance.collection('Jobs').doc(jobId).update({
                    'popularity': currentPopularity + 1,
                  });

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Color(klightGrey.value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(job['imageUrl']),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Heading(
                                      text: job['companyName'],
                                      color: Color(kDark.value),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Text(
                                      job['jobTitle'],
                                      style: TextStyle(
                                        color: Color(kDarkGrey.value),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, bottom: 16),
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
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Heading(
                              text: "${job['salary']}/ Month",
                              color: Color(kDark.value),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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
