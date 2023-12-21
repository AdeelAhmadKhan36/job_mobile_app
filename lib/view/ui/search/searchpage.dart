import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/Custom_Text_Field.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
class Search_Page extends StatelessWidget {
  const Search_Page({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search=TextEditingController()    ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kprimary_colors.value),
        iconTheme: IconThemeData(color: Color(kLight.value)),
        title: Custom_Text_Field(
          hintText: 'Search for a job',
          controller:search,
          suffixicon: GestureDetector(
            onTap: (){

            },
            child: Icon(Icons.search_sharp,color: Colors.white,),
          ),
        ),
        elevation: 0,

      ),
      body:
      Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [

            Image.asset("Assets/Images/search-preview.png"),
            Heading(text: "Start Searching For Jobs", color:Color(kDark.value), fontSize:28, fontWeight:FontWeight.bold)

          ],
        ),
      ),


    );
  }
}
