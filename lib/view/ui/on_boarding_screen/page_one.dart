import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_style.dart';
import 'package:job_mobile_app/view/common/height_spacer.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';

class Page_One extends StatelessWidget {
  const Page_One({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(kprimary_colors.value),
            image: const DecorationImage(
                image: AssetImage('Assets/Images/Coding Force.png'),
                fit: BoxFit.contain),
          ),
        ),
        // height_spacer(size: 10),
        // Reuseable_Text(text: 'Find Your Dream Job', style:app_style(40,Color(kLight.value),
        //fw),)
        Padding(
          padding: const EdgeInsets.only(top: 550),
          child: Column(
            children: [
              Center(
                  child: ReusableText(
                text: 'Find Your Dream Job',
                fontSize: 32,
                fontWeight: FontWeight.w500,
              )),
              const SizedBox(
                height: 10,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'We help you to find your dream job according to your skill set,location and preferences to\n',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: 'build your career',
                        style: TextStyle(
                          color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              )

            ],
          ),
        )
      ]),
    );
  }
}
