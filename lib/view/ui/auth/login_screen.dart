import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/controllers/login_provider.dart';
import 'package:job_mobile_app/home_screen.dart';
import 'package:job_mobile_app/utils/Round_button.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/Main_Screen.dart';
import 'package:job_mobile_app/view/ui/auth/signup_screen.dart';
import 'package:job_mobile_app/view/ui/auth/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../../resources/constants/app_colors.dart';



class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key}); // Corrected the constructor

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool _isObscure3 = true;
  bool visible = false;
  bool loading = false;
  bool _hasError = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Corrected the method override with @override
  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Custom_AppBar(
              title: Text('Login', style: TextStyle(color: Colors.black)),
              child: GestureDetector(
                onTap: () {},
                child: Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading(
                  text: 'Welcome Back!',
                  color: Color(kDark.value),

                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                ReusableText(
                  text: 'Fill the details to login to your account', // Corrected the text
                  color: Color(kDarkGrey.value),
                ),
                SizedBox(height: 20),
                Container(
               // Adjust width as needed
                  child: Column(
                    children: [
                    TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(kGrey.value),
                      hintText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]")
                          .hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure3,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                         loginNotifier.obsecuretext=!loginNotifier.obsecuretext;
                        },
                        child: Icon(
                          _isObscure3 ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      filled: true,
                      fillColor: Color(kGrey.value),
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      final regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid password (min. 6 characters)";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 40),
                  RoundButton(
                    title: 'Login',
                    onTap: () {
                      Get.to(()=>Main_Screen());

                    },
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Don't have an account "),
                      InkWell(
                        onTap: () {
                          Get.off(SignUp_Screen());
                        },
                        child: Text('Signup', style: TextStyle(color: Color(kblue.value)),
                        ),
                      ),
                    ],
                  )],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
