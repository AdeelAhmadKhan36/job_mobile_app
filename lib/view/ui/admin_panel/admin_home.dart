import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/admin_panel/applications.dart';
import 'package:job_mobile_app/view/ui/admin_panel/post_job.dart';
import 'package:job_mobile_app/view/ui/admin_panel/selectJobS_Screen.dart';


class EmployerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(kDarkBlue.value),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'Assets/Images/dashboard(1).png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Heading(
                                text: 'Welcome to your dashboard',
                                color: Color(kLight.value),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 10),
                              const Flexible(
                                child: Text(
                                  'This dashboard has been created to help you get started. You can post jobs and view post analytics.',
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(kprimary_colors.value),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(klightpink.value),
                                  minimumSize: const Size(100, 100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.indigo,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Heading(
                                      text: '50+',
                                      color: Color(kLight.value),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    Heading(
                                      text: 'Job Posted',
                                      color: Color(kLight.value),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: ElevatedButton(
                                  onPressed: () {

                                    Get.to(SelectJobScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(klightgreen.value),
                                    minimumSize: const Size(100, 100),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.indigo,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Heading(
                                        text: '100+',
                                        color: Color(kLight.value),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 10),
                                      Heading(
                                        text: 'Application',
                                        color: Color(kLight.value),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(JobPostScreen());
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(kDarkBlue.value),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Heading(
                                  text: 'Post a Job',
                                  color: Color(kLight.value),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(kDarkBlue.value),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Heading(
                                text: 'Job Analytics',
                                color: Color(kLight.value),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



