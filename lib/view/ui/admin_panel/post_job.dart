
import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';


class JobPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Adjust the height as needed
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            color: Color(kmycolor.value), // Change the color as needed
          ),
          child: Center(
            child: Text(
              'Post a Job',
              style: TextStyle(
                color: Colors.white, // Change the text color as needed
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            SizedBox(height: 16.0),
            // Company logo file picker
            Text('Choose Company Logo:',style: TextStyle(),),

            // Implement file picker widget here
            // Example: ImagePicker button
            SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                // Implement file picker logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(kmycolor.value),
                minimumSize: const Size(150, 50),
              ),
              child: Text('Choose File'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Job Title'),
            ),
            SizedBox(height: 16.0),
            // Dropdown menu for selecting salary
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Salary'),
              items: [
                '10000',
                '15000',
                '20000',
                '25000',
                '30000',
                '35000',
                '40000',
                '45000',
                '50000',
                '55000',
                '60000',
                '65000',
                '70000',
                '75000',
                '80000',
                '85000',
                '90000',
                '95000',
                '100000',
                '120000',
                '130000',
                '140000',
                '150000',
                // Add more values as needed
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                // Handle the selected value
              },
            ),
            SizedBox(height: 16.0),
            // TextField for job description
            TextField(
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Job Description (at least 50 words)', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16.0),
            // TextField for job requirements
            TextField(
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Requirements for the Job', border: OutlineInputBorder()),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Implement posting logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(kmycolor.value),
                minimumSize: Size(150,50)
              ),
              child: Text('Post Job'),
            ),
          ],
        ),
      ),
    );
  }
}
