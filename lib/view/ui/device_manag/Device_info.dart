import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/custom_outline_button.dart';



class Device_Info extends StatelessWidget {
  const Device_Info({
    Key? key,
    required this.device,
    required this.date,
    required this.ipAddress,
    required this.onSignOut,
  }) : super(key: key);

  final String device;
  final String date;
  final String ipAddress;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          device,
          style: TextStyle(
            fontSize: 22,
            color: Color(kDark.value),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(kDarkGrey.value),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  ipAddress,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(kDarkGrey.value),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Custom_Button(
              text: "Sign Out",
              color: Color(kOrange.value),
              height: 30,
              width: 100,
              onTap: onSignOut, // Call the sign-out callback
            ),
          ],
        )
      ],
    );
  }
}

