import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/utils/utils.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/Jobs/Jobs_page.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';

class BookmarkService {
  static Future<List<DocumentSnapshot>> fetchBookmarkedJobs() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('bookmarks').get();
      List<DocumentSnapshot> bookmarkedJobDocuments = querySnapshot.docs;
      return bookmarkedJobDocuments;
    } catch (e) {
      print('Error fetching bookmarked jobs: $e');
      return [];
    }
  }
}

class BookMark_Screen extends StatefulWidget {
  const BookMark_Screen({Key? key}) : super(key: key);

  @override
  State<BookMark_Screen> createState() => _BookMark_ScreenState();
}

class _BookMark_ScreenState extends State<BookMark_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Jobs', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(kmycolor.value),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.to(const drawer_animated());
          },
        ),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: BookmarkService.fetchBookmarkedJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading bookmarked jobs'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookmarked jobs'));
          } else {
            List<DocumentSnapshot> bookmarkedJobs = snapshot.data!;
            return ListView.builder(
              itemCount: bookmarkedJobs.length,
              itemBuilder: (context, index) {
                var jobData = bookmarkedJobs[index].data() as Map<String, dynamic>;

                String companyName = jobData['companyName'] ?? '';
                String jobTitle = jobData['jobTitle'] ?? '';
                String imageUrl = jobData['imageUrl'] ?? '';
                String salary = jobData['salary'] ?? '';

                return VerticalTile(
                  onTap: () {
                    // Handle tap on a bookmarked job
                  },
                  companyName: companyName,
                  jobTitle: jobTitle,
                  imageUrl: imageUrl,
                  salary: salary,
                  index: index,
                  bookmarkedJobs: bookmarkedJobs,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class VerticalTile extends StatelessWidget {
  const VerticalTile({
    Key? key,
    this.onTap,
    required this.companyName,
    required this.jobTitle,
    required this.imageUrl,
    required this.salary,
    required this.index,
    required this.bookmarkedJobs,
  }) : super(key: key);

  final void Function()? onTap;
  final String companyName;
  final String jobTitle;
  final String imageUrl;
  final String salary;
  final int index;
  final List<DocumentSnapshot> bookmarkedJobs;


  @override
  Widget build(BuildContext context) {
    var jobData = bookmarkedJobs[index].data() as Map<String, dynamic>;
    var documentId = bookmarkedJobs[index].id;

    return Dismissible(
      key: Key(documentId),
      direction: DismissDirection.horizontal,
      background: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),

      confirmDismiss: (direction) async {

        return true;
      },

      onDismissed: (direction) async{
        // Remove the item from the bookmarks list
        Utils().toastMessage("Bookmarked has been removed Successfully");

    await FirebaseFirestore.instance.collection('bookmarks').doc(documentId).delete();

      },

      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Heading(
                              text: companyName,
                              color: Color(kDark.value),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: TextStyle(
                                color: Color(kDarkGrey.value),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(text: jobTitle.length > 17 ? jobTitle.substring(0, 17) + '...' : jobTitle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60, bottom: 25),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => Job_Page(
                            title: companyName,
                            id: bookmarkedJobs[index].id,
                            showApplyButton: true,
                          ));
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(kLight.value),
                          child: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Heading(
                    text: "$salary/Monthly",
                    color: Color(kDark.value),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


