import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';

class EmployerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      weight: 50,
                      size: 30,
                    ),
                    onPressed: () {
                      // Handle menu button press
                    },
                  ),
                  const SizedBox(width: 80),
                  Heading(
                      text: "Job Portal",
                      color: Color(kDark.value),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.mark_unread_chat_alt, size: 30),
                    onPressed: () {
                      // Handle search icon press
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(kDarkBlue.value),
                      minimumSize: const Size(180, 50),
                      elevation: 10, // Elevation (shadow depth)
                      shadowColor: Colors.blue,
                    ),
                    child: const Text(
                      'Dashboard',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(kDarkBlue.value),
                      minimumSize: const Size(180, 50),
                      elevation: 10, // Elevation (shadow depth)
                      shadowColor: Colors.blue,
                    ),
                    child: const Text(
                      'Dashboard',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Heading(
                  text: 'My Dashboard',
                  color: Color(kDark.value),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(kDarkBlue.value),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('Assets/Images/dashboard(1).png'),
                          width: 120,
                          height: 120,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Heading(
                                text: 'Welcome to your \n dashboard',
                                color: Color(kLight.value),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            const SizedBox(height: 10,),
                            const Text(
                              'This dashboard has been created\n to help you to get started, \n You can Post the job and also can \n view poats analytics',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(kprimary_colors.value),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(klightpink.value),
                                    minimumSize: const Size(150, 80),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Button border radius
                                      side: const BorderSide(
                                        color: Colors.indigo, // Border color
                                        width: 2.0, // Border width
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Heading(
                                            text: '50+',
                                            color: Color(kLight.value),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Heading(
                                            text: 'Job Posted',
                                            color: Color(kLight.value),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(klightgreen.value),
                                    minimumSize: const Size(150, 80),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Button border radius
                                      side: const BorderSide(
                                        color: Colors.indigo, // Border color
                                        width: 2.0, // Border width
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Heading(
                                            text: '100+',
                                            color: Color(kLight.value),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Heading(
                                            text: 'Applications',
                                            color: Color(kLight.value),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color(kDarkBlue.value),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Heading(
                                      text: 'Post a Job',
                                      color: Color(kLight.value),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color(kDarkBlue.value),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Heading(
                                      text: 'Job Analytics',
                                      color: Color(kLight.value),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
