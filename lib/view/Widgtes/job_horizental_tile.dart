import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/Jobs/Jobs_page.dart';

class JobHorizontalTile extends StatelessWidget {
  final void Function()? onTap;
  const JobHorizontalTile({Key? key, this.onTap,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
         Get.to(()=>Job_Page (title: 'NetSole', id: '11',));

      },
      child: Container(
        height: 300,
        width: 400,

        color: Color(klightGrey.value),
        child: Padding(
          padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(width:10,),
                  Heading(text: "NetSole PVT", color: Color(kDark.value), fontSize: 26, fontWeight: FontWeight.w600)
                ],
              ),
              SizedBox(height: 30,),
              Heading(text: "Senior Flutter Developer",  color: Color(kDark.value), fontSize: 20, fontWeight: FontWeight.w600),
              Text("Islamabad Pakistan",style: TextStyle(color: Color(kDarkGrey.value),fontSize:20,fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Heading(text: "80K/Monthly",  color: Color(kDark.value), fontSize: 20, fontWeight: FontWeight.w600),
                  SizedBox(height: 100,),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(kLight.value),
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
