import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_constant.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
              color: Color(kprimary_colors.value),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Custom_AppBar(
            text: "Profile",
            child: Column(
              children: [
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        value == 0 ? value = 1 : value = 0;
                      });
                    },
                    child:IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        // Handle back button press
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                    ),



                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("Assets/Images/profile.png"),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Heading(
                            text: "Adeel Ahmad Khan",
                            color: Color(kDark.value),
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        SizedBox(
                          width: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'Assets/Images/pencil.png', // Replace 'your_image.png' with the actual asset image path
                            width: 30, // Adjust the width as needed
                            height: 30, // Adjust the height as needed
                            // You can customize other properties like fit, alignment, etc.
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Color(kDark.value),
                          weight: 10,
                        ),
                        ReusableText(
                          text: "Mansehra KPK Pakistan",
                          color: Color(kDarkGrey.value),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 130,
              width: double.infinity,
              color: Color(klightGrey.value),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      width: 80,
                      color: Color(kLight.value),
                      child: Icon(Icons.picture_as_pdf_rounded,
                          size: 70, color: Colors.orange),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Heading(
                              text: "Resume from JobPortal",
                              color: Color(kDark.value),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          ReusableText(
                            text: "JobPortal Resume",
                            color: Color(kDark.value),
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: GestureDetector(
                        onTap: () {},
                        child: Heading(
                            text: "Edit",
                            color: Color(kRed.value),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: Color(klightGrey.value),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Color(kLight.value),
                      child: Icon(
                        Icons.email_rounded,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Heading(
                      text: "adeelahmad1831@gamil.com",
                      color: Color(kDark.value),
                      fontSize: 18,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: Color(klightGrey.value),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 30,
                      width: 30,
                      // color: Color(kLight.value),
                      child: Image(image: AssetImage("Assets/Images/pk.png"))
                    ),
                  ),
                  Heading(
                      text: "+92-34654034-76",
                      color: Color(kDark.value),
                      fontSize: 18,
                      fontWeight: FontWeight.w600)
                ],
                
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 337,
              width: double.infinity,
              color: Color(klightGrey.value),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:300),
                    child: Heading(
                        text: "Skills",
                        color: Color(kDark.value),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 300, // Set a finite height for the parent container
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: ListView.builder(
                        itemCount: skills.length,
                        itemBuilder: (context, index) {
                          final skill=skills[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 8), // Adjust as needed
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 2), // Optional: Add a subtle shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                skill,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )

                  )

                ],

              ),
            ),


          ],
        ),
      ),
    );
  }
}
