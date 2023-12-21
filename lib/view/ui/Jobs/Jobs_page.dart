import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/Widgtes/requirements.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/custom_outline_button.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/auth/profile.dart';

class Job_Page extends StatefulWidget {
  const Job_Page({super.key, required this.title, required this.id});

  final String title;
  final String id;
  @override
  State<Job_Page> createState() => _Job_PageState();
}

class _Job_PageState extends State<Job_Page> {
  @override
  Widget build(BuildContext context) {
    print('Title: ${widget.title}');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Custom_AppBar(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(kDark.value),
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.bookmark),
              )
            ],
          ),
        ),
      ),
      body: 
      
      Stack(
        children: [SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Color(klightGrey.value),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("Assets/Images/flutter.png"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Heading(
                          text: "Senior Flutter Developer",
                          color: Color(kDark.value),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                      Text(
                        "Islamabad Pakistan",
                        style: TextStyle(
                            color: Color(kDarkGrey.value),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 52, right: 52),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Custom_Button(
                              height: 30,
                              width: 85,
                              color2: Color(kLight.value),
                              text: 'Full Time',
                              color: Color(kOrange.value),
                            ),
                            Heading(
                                text: "80K/Monthly",
                                color: Color(kDark.value),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Heading(
                    text: "Job Description",
                    color: Color(kDark.value),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                SizedBox(height: 10,),

                Text( 'A flutter Mobile App develper responsible for design, develop, and maintain high-quality mobile applications using Flutter and Dart. Drive the creation of user-friendly interfaces, ensure optimal performance across devices, and implement robust app features. Collaborate with cross-functional teams to innovate and contribute throughout the app development lifecycle. Join us to shape the future of mobile experiences and be part of impactful, dynamic development projects.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(kDarkGrey.value),
                  ), textAlign: TextAlign.justify,

                ),
                SizedBox(
                  height: 20,
                ),
                Heading(
                    text: "Requirements",
                    color: Color(kDark.value),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                SizedBox(height: 10,),
                BulletPointsList(
                  points: [
                    'Minimum of a years of professional experience in mobile app development using Flutter.',
                    'Bachelor\'s degree in Computer Science, Software Engineering, or a related field.',
                    'Proficient in Dart programming language and the Flutter framework.',
                    'Strong understanding of mobile application development concepts, architecture, and design patterns.',
                    'Experience working with RESTful APIs and third-party integrations.',
                    'Familiarity with Agile methodologies and version control systems (e.g., Git).',
                    'Knowledge of mobile app deployment processes for iOS and Android platforms.',
                    'Excellent problem-solving skills and ability to work in a collaborative team environment.',


                    ],
                ),


              ],

            ),
          ),
        ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>Profile_Page());
                },
                child: Container(

                  height: 50,
                  width: double.infinity,
                  color: Color(kOrange.value),

                  child: Center(
                    child: Text(
                      "Apply Now",
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),


                ),
              ),


            ),
          )
        ]
            
      ),
    );
  }
}
