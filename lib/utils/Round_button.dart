import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
class RoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool loading;

  const RoundButton({super.key,required this.title,required this.onTap,this.loading=false});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color:Color( kprimary_colors.value),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Center(
          child:loading?CircularProgressIndicator(strokeWidth: 6,color: Colors.white,): Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
