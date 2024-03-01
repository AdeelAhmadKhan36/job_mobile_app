
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:job_mobile_app/utils/utils.dart';

class JobPostScreen extends StatefulWidget {
  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  bool loading=false;
  File? _image;
  final picker = ImagePicker();
  final _formkey=GlobalKey<FormState>();
  String  selectedSalary = ''; // Add this variable to store the selected salary


  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobtitleController=TextEditingController();
  TextEditingController salaryController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController requirementController=TextEditingController();

  //Initializing Firebase Firestore
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;



  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      debugPrint("Image Picked Successfully");
    } else {
      print("No Image has been picked");
    }
  }
  Future<void> postJob() async {


    // Validate the form before submitting
    if (_formkey.currentState!.validate()) {
      try {
        // Create a reference to the logo folder in Firebase Storage
        final firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child('/Logos');

        // Generate a unique name for the image
        String imageName = DateTime.now().millisecondsSinceEpoch.toString() +
            "_" +
            _image!.path.split('/').last;

        // Upload the image to Firebase Storage
        await storageRef.child(imageName).putFile(_image!);
        print("Image uploaded successfully");

        // Get the download URL of the uploaded image
        String imageUrl =
        await storageRef.child(imageName).getDownloadURL();

        // Create a map containing job data
        Map<String, dynamic> jobData = {
          'companyName': companyNameController.text,
          'imageUrl': imageUrl,
          'jobTitle': jobtitleController.text,
          'salary': selectedSalary,
          'jobDescription': descriptionController.text,
          'jobRequirements': requirementController.text,
          // Add more fields as needed
        };

        // Submit job data to Firestore
        await _firestore.collection('Jobs').add(jobData);



        // Clear the text field controllers
        companyNameController.clear();
        jobtitleController.clear();

        descriptionController.clear();
        requirementController.clear();



        // Clear the image selection
        setState(() {
          _image = null;
        });

        setState(() {
          selectedSalary = ''; // Set it to an empty string or null based on your logic
        });


        Utils().toastMessage("Job submitted successfully");
        setState(() {
          loading=false;
        });
      } catch (error) {
        Utils().toastMessage(error.toString());
        print("Error uploading image: $error");
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            color: Color(kmycolor.value),
          ),
          child: Center(
            child: Text(
              'Post a Job',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              TextFormField(
                controller: companyNameController,
                decoration: InputDecoration(labelText: 'Company Name'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Choose Company Logo:',
                style: TextStyle(),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  getImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(kmycolor.value),
                  minimumSize: const Size(150, 50),
                ),
                child: Text(
                      'Choose File',
                  style: TextStyle(color: Color(kLight.value)),
                ),
              ),
              SizedBox(height: 16.0),
              _image != null
                  ? Column(
                children: [
                  SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Text('Selected Image:'),
                        SizedBox(width: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(' ${_image!.path.split('/').last}',style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),

                ],
              )
                  : Container(),
              SizedBox(height: 16.0),

              SizedBox(height: 16.0),
              TextFormField(
                controller: jobtitleController,
                decoration: InputDecoration(labelText: 'Job Title'),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedSalary,

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
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {

                  setState(() {
                    selectedSalary = value ?? ''; // Update the selectedSalary variable
                  });

                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Job Description (at least 50 words)',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                maxLines: 5,
                controller: requirementController,
                decoration: InputDecoration(
                    labelText: 'Requirements for the Job',
                    border: OutlineInputBorder()),
              ),

              SizedBox(height:40),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });

                    await postJob();

                    setState(() {
                      loading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(kmycolor.value),
                  minimumSize: Size(150, 50),
                ),
                child: loading
                    ? CircularProgressIndicator(color: Colors.white,)
                    : Text(
                  'Post Job',
                  style: TextStyle(color: Color(kLight.value)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
