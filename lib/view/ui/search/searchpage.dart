import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';

class Search_Page extends StatefulWidget {
  const Search_Page({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search_Page> {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

  void searchJobs() async {
    String searchTerm = searchController.text.trim().toLowerCase();

    if (searchTerm.isNotEmpty) {
      var titleResults = await FirebaseFirestore.instance
          .collection('Jobs')
          .where('jobTitleLowercase', isEqualTo: searchTerm)
          .get();

      var locationResults = await FirebaseFirestore.instance
          .collection('Jobs')
          .where('jobLocationLowercase', isEqualTo: searchTerm)
          .get();

      setState(() {
        searchResults = [...titleResults.docs, ...locationResults.docs];
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kprimary_colors.value),
        iconTheme: IconThemeData(color: Color(kLight.value)),
        title: TextField(
          controller: searchController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search for a job',
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: GestureDetector(
              onTap: searchJobs,
              child: Icon(Icons.search_sharp, color: Colors.white),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              if (searchResults.isNotEmpty)
                Column(
                  children: searchResults.map((job) {
                    var jobData = job.data() as Map<String, dynamic>;
                    return vertical_tile(
                      onTap: () {
                        // Handle tap on a search result
                      },
                      companyName: jobData['companyName'],
                      jobTitle: jobData['jobTitle'],
                      imageUrl: jobData['imageUrl'],
                      salary: jobData['salary'],
                    );
                  }).toList(),
                ),
              if (searchResults.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Column(
                    children: [
                      Image.asset("Assets/Images/search-preview.png"),
                      Heading(
                        text: "Start Searching For Jobs",
                        color: Color(kDark.value),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class vertical_tile extends StatelessWidget {
  const vertical_tile({
    Key? key,
    this.onTap,
    required this.companyName,
    required this.jobTitle,
    required this.imageUrl,
    required this.salary,
  }) : super(key: key);

  final void Function()? onTap;
  final String companyName;
  final String jobTitle;
  final String imageUrl;
  final String salary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  backgroundImage: AssetImage(imageUrl),
                ),
                SizedBox(width: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Heading(
                          text: companyName,
                          color: Color(kDark.value),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        Text(
                          jobTitle,
                          style: TextStyle(
                            color: Color(kDarkGrey.value),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Heading(
                text: "${salary}/ Monthly",
                color: Color(kDark.value),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
