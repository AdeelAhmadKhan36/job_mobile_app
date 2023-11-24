import 'package:flutter/material.dart';


import '../resources/fonts/app_fonts.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Assets/Images/splash_img.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Text(
                    "Find Your",
                    style: Custom_Font.regular,
                  )),
              Center(child: Text('Dream Job', style: Custom_Font.bold)),
            ],
          ),
          Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 450),
                    child: Text(
                        "Find jobs,create trackable resumes and",style: Custom_Font.buttom_text,),
                  )),
              Center(
                child: Text(
                  "enrich your applications",
                  style: Custom_Font.buttom_text,
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:650),
            child: Center(
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 5,
                    ),
                    color: Colors.deepOrange,),
                  child: Icon(Icons.arrow_forward_sharp,color: Colors.white,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
