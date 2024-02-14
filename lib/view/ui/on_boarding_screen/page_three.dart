
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/custom_outline_button.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/auth/login_screen.dart';
import 'package:job_mobile_app/view/ui/auth/usersignup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Page_Three extends StatelessWidget {
  const Page_Three({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(
          width:double.infinity,
          height:double.infinity,
          decoration: BoxDecoration(
            color: Color(kLightBlue.value),
            image: const DecorationImage(
                image: AssetImage('Assets/Images/gr.png'),
                fit: BoxFit.contain),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(top: 650),
            child: Column(
              children: [
                Center(
                    child: ReusableText(
                      text: 'Welcome to JobHub',
                      fontSize: 33,
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
                ),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Custom_Button(
                      onTap:()async{

                        final SharedPreferences prefs=await SharedPreferences.getInstance();
                        await prefs.setBool('entry point', true);

                        Get.to(()=>Login_Screen());
                      },
                      text: 'Login',
                      color: Color(kLight.value),
                      width: 150,
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>UserSignUp_Screen());
                      },
                      child: Container(
                        width: 150,
                        height: 40,
                        color: Color(kLight.value),
                        child: Center(
                          child: ReusableText(
                            text: 'SignUp',
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 10,),
                ReusableText(text: 'Continue as a Guest',
                fontWeight: FontWeight.bold,
                )

              ],
            ),
          )

      ]
      ),


    );
  }
}
