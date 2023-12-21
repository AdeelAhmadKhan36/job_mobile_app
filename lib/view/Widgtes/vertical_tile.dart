import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
class vertical_tile extends StatelessWidget {
  const vertical_tile({super.key, this.onTap});


  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        height: 130,
        width: double.infinity,
        color: Color(klightGrey.value),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("Assets/Images/codematics.jpg"),

                ),
                SizedBox(width:10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Heading(text: "Codematics", color: Color(kDark.value), fontSize: 20, fontWeight: FontWeight.w600),
                        Text("Game Developer",style: TextStyle(color: Color(kDarkGrey.value),fontSize:20,fontWeight: FontWeight.bold),),

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 70,),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    )

                  ],
                )
              ],
            ),
            SizedBox(height:20,),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Heading(text: "60K/Monthly",  color: Color(kDark.value), fontSize: 20, fontWeight: FontWeight.w600),
            ),


          ],
        ),
      ),
    );
  }
}
