import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/custom_outline_button.dart';

class Device_Info extends StatelessWidget {
  const Device_Info({super.key, required this.location, required this.device,  required this.ipAdress, required this.platform, required this.date});

  final String location;
  final String device;
  final String platform;
  final String ipAdress;
  final String date;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          platform,
          style: TextStyle(fontSize: 22,color: Color(kDark.value),fontWeight: FontWeight.bold),
        ) ,
        Text(
          device,
          style: TextStyle(fontSize: 22,color: Color(kDark.value),fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  date,
                  style: TextStyle(fontSize: 16,color: Color(kDarkGrey.value),fontWeight: FontWeight.w400),
                ) ,
                Text(
                  ipAdress,
                  style: TextStyle(fontSize: 16,color: Color(kDarkGrey.value),fontWeight: FontWeight.w400),
                ) ,
              ],
            ),
            Custom_Button(text: "Sign Out", color: Color(kOrange.value),
            height: 30,
              width: 100,
            )
          ],
        )
      ],
    );
  }
}
