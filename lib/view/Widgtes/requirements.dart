
import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';

class BulletPointsList extends StatelessWidget {
  final List<String> points;

  BulletPointsList({required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Take the full available width
      child: ListView.builder(
        shrinkWrap: true, // Allow the ListView to take the height it needs
        itemCount: points.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_right,
                  color: Colors.black, // Customize the bullet point color
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    points[index],
                    style:  TextStyle(fontSize: 16, color: Color(kDarkGrey.value),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
