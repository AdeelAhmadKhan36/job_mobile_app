import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/Jobs/Jobs_page.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({Key? key, required Null Function() onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Jobs')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var mostRecentJob = snapshot.data?.docs?.isNotEmpty ?? false
            ? snapshot.data!.docs![0]
            : null;

        if (mostRecentJob == null) {
          return Center(child: Text('No recent job available.'));
        }

        var companyName = mostRecentJob['companyName'];
        var jobTitle = mostRecentJob['jobTitle'];
        var imageUrl = mostRecentJob['imageUrl'];
        var salary = mostRecentJob['salary'];

        return GestureDetector(
          onTap: () {
            // Handle onTap event
          },
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
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Heading(
                            text: companyName,
                            color: Color(kDark.value),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              jobTitle,
                              style: TextStyle(
                                color: Color(kDarkGrey.value),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, bottom: 18),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => Job_Page(
                            title: mostRecentJob['companyName'],
                            id: mostRecentJob.id,
                          ));
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(kLight.value),
                          child: Icon(Icons.arrow_forward_ios_rounded, color: Color(kOrange.value)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Heading(
                    text: "${salary}/ Month",
                    color: Color(kDark.value),
                    fontSize:16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
