
import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
class Page_Two extends StatelessWidget {
  const Page_Two({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(kprimary_colors.value),
              image: const DecorationImage(
                  image: AssetImage('Assets/Images/page2.png'),
                  fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 530),
            child: Column(
              children: [
                Center(
                    child: ReusableText(
                      text: 'Stable Yourself',
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    )),
                Center(
                    child: ReusableText(
                      text: 'With Your Ability',
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
        ],
      )
    );
  }
}
