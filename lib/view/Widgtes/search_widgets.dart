import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';

class SearchWidget extends StatelessWidget {
  final void Function()? onTap;

  const SearchWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: Color(kLight.value),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Search for Job",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(kLight.value),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
