import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';

class search_widget extends StatelessWidget {
  final void Function()? onTap;

  const search_widget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      weight: 50,
                      color: Color(kOrange.value),
                      size: 30,
                    ),
                    SizedBox(width: 20,),
                    Text(
                       "Search for Job",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(kOrange.value),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.tune,
              size: 30,
              color: Color(kOrange.value),
            ),
          ],
        )
      ],
    );
  }
}

