import 'package:flutter/material.dart';import 'package:cloud_firestore/cloud_firestore.dart';import 'package:get/get.dart';import 'package:job_mobile_app/resources/constants/app_colors.dart';import 'package:job_mobile_app/services/notification_services.dart';import 'package:job_mobile_app/view/Widgtes/job_horizental_tile.dart';import 'package:job_mobile_app/view/Widgtes/search_widgets.dart';import 'package:job_mobile_app/view/Widgtes/vertical_tile.dart';import 'package:job_mobile_app/view/common/reuse_able_text.dart';import 'package:job_mobile_app/view/ui/Jobs/Jobs_page.dart';import 'package:job_mobile_app/view/ui/Jobs/recent_viewall.dart';import 'package:job_mobile_app/view/ui/Jobs/viewall_jobs.dart';import 'package:job_mobile_app/view/ui/auth/login_screen.dart';import 'package:job_mobile_app/view/ui/search/searchpage.dart';class Home_Screen extends StatefulWidget {  const Home_Screen({Key? key}) : super(key: key);  @override  State<Home_Screen> createState() => _Home_ScreenState();}class _Home_ScreenState extends State<Home_Screen> {  Notification_Services notificationServices=Notification_Services();  @override  void initState() {    // TODO: implement initState    super.initState();    notificationServices.Request_NotificationPermission();    notificationServices.getDeviceToken().then((value){      debugPrint("Device Token is");      debugPrint(value);    });    notificationServices.isTokenRefresh();    notificationServices.firebaseintit();  }  @override  Widget build(BuildContext context) {    return Scaffold(      body: SafeArea(        child: Padding(          padding: EdgeInsets.all(20),          child: SingleChildScrollView(            child: Column(              crossAxisAlignment: CrossAxisAlignment.start,              children: [                Column(                  crossAxisAlignment: CrossAxisAlignment.start,                  children: [                    Heading(                      text: 'Search\nFind and Apply',                      color: Color(kDark.value),                      fontSize: 32,                      fontWeight: FontWeight.bold,                    ),                    SizedBox(height: 10),                    ElevatedButton(                      onPressed: () {                        Get.to(Login_Screen());                      },                      child: Text(                        "Join",                        style: TextStyle(color: Colors.white),                      ),                      style: ElevatedButton.styleFrom(                        backgroundColor: Color(kLightBlue.value),                        shape: RoundedRectangleBorder(                          borderRadius: BorderRadius.circular(10.0),                        ),                      ),                    ),                  ],                ),                SizedBox(height: 20),                SearchWidget(                  onTap: () {                    Get.to(Search_Page());                  },                ),                SizedBox(height: 20),                Row(                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                  children: [                    GestureDetector(                      onTap: () {},                      child: Heading(                        text: 'Popular Jobs',                        color: Color(kDark.value),                        fontSize: 18,                        fontWeight: FontWeight.bold,                      ),                    ),                    GestureDetector(                      onTap: () {                       Get.to(ViewAllScreen());                      },                      child: Heading(                        text: 'View all',                        color: Color(kOrange.value),                        fontSize: 16,                        fontWeight: FontWeight.w600,                      ),                    ),                  ],                ),                SizedBox(height: 20),                Container(                  height: 280,                  width: double.infinity,                  child: FutureBuilder<QuerySnapshot>(                    future: FirebaseFirestore.instance.collection('Jobs').get(),                    builder: (context, snapshot) {                      if (snapshot.connectionState == ConnectionState.waiting) {                        return CircularProgressIndicator();                      } else if (snapshot.hasError) {                        return Text('Error: ${snapshot.error}');                      } else {                        final documents = snapshot.data!.docs;                        return PageView.builder(                          scrollDirection: Axis.horizontal,                          itemCount: documents.length,                          controller: PageController(viewportFraction: 0.9),                          itemBuilder: (context, index) {                            final job =                                documents[index].data() as Map<String, dynamic>;                            final jobId = documents[index].id;                            return Padding(                              padding: EdgeInsets.only(right: 12),                              child: JobHorizontalTile(                                onTap: () {                                  Navigator.push(                                    context,                                    MaterialPageRoute(                                      builder: (context) => Job_Page(                                          id: jobId,                                          title: job['jobTitle'],                                        showApplyButton: true,                                      ),                                    ),                                  );                                },                              ),                            );                          },                        );                      }                    },                  ),                ),                SizedBox(                    height:                        20), // Add more widgets for recently posted jobs, etc.                Row(                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                  children: [                    GestureDetector(                      onTap: () {                        Get.to(RecentViewAllScreen());                      },                      child: Heading(                        text: 'Recently Posted',                        color: Color(kDark.value),                        fontSize: 18, // Adjusted font size                        fontWeight: FontWeight.bold,                      ),                    ),                    GestureDetector(                      onTap: () {                        Get.to(RecentViewAllScreen());                      },                      child: Heading(                        text: 'View all',                        color: Color(kOrange.value),                        fontSize: 16, // Adjusted font size                        fontWeight: FontWeight.w600,                      ),                    ),                  ],                ),                SizedBox(height: 20),                VerticalTile(onTap: () {                  print('VerticalTile tapped!');                }),              ],            ),          ),        ),      ),    );  }}