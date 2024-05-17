import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_mobile_app/view/ui/Jobs/Jobs_page.dart';

import '../../../resources/constants/app_colors.dart';

class PostedJobs extends StatefulWidget {
  final String? adminUID;

  const PostedJobs({Key? key, this.adminUID}) : super(key: key);

  @override
  State<PostedJobs> createState() => _PostedJobsState();
}

class _PostedJobsState extends State<PostedJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posted Jobs',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Admins')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('my_jobs')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Applications found'));
          }

          List<DocumentSnapshot> jobDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: jobDocs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot jobDoc = jobDocs[index];
              String jobTitle = jobDoc['jobTitle'];
              String imageUrl = jobDoc['imageUrl'];

              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed:(direction){
                  FirebaseFirestore.instance
                      .collection('Admins')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('my_jobs')
                      .doc(jobDoc.id)
                      .delete();
                } ,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(() => Job_Page(
                        title: jobDoc['companyName'],
                        id: jobDoc.id,
                        showApplyButton: false,
                      ));
                    },
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

                                Image.network(
                                  imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  jobTitle,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            Icon(Icons.work, size: 30),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
