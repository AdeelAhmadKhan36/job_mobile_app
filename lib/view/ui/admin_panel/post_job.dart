//Post Job Screen

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String ? selectedSalary = '';
  String ? selectedJobTiming = '';


  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobtitleController=TextEditingController();
  TextEditingController joblocationController=TextEditingController();
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

        // Get the current user ID
        String? userId = FirebaseAuth.instance.currentUser?.uid;

        // Check if the user ID is not null
        if (userId != null) {
          // Create a map containing job data along with the current user ID
          Map<String, dynamic> jobData = {
            'adminUID': FirebaseAuth.instance.currentUser!.uid, // Store the admin's UID
            'companyName': companyNameController.text,
            'imageUrl': imageUrl,
            'jobTitle': jobtitleController.text,
            'jobLocation': joblocationController.text,
            'jobTiming': selectedJobTiming,
            'salary': selectedSalary,
            'jobDescription': descriptionController.text,
            'jobRequirements': requirementController.text,
            'applicationReceived': false,
            'timestamp': FieldValue.serverTimestamp(),
            'popularity': 0, // Add this field

            // Add more fields as needed
          };

          //Submit job data to Firestore
          DocumentReference jobRef =
          await _firestore.collection('Jobs').add(jobData);

          // Check if the job was successfully added to Firestore
          if (jobRef.id.isNotEmpty) {
            // Create a subcollection under Admins for the current user
            CollectionReference myJobsRef = _firestore
                .collection('Admins')
                .doc(userId)
                .collection('my_jobs');

            // Store job details in the my_jobs subcollection
            await myJobsRef.doc(jobRef.id).set(jobData);

            // Clear the text field controllers
            companyNameController.clear();
            jobtitleController.clear();
            descriptionController.clear();
            requirementController.clear();
            joblocationController.clear();

            // Clear the image selection
            setState(() {
              _image = null;
            });

            setState(() {
              selectedSalary = null; // Set it to an empty string or null based on your logic
            });

            Utils().toastMessage("Job submitted successfully");
          }
        }
      } catch (error) {
        Utils().toastMessage(error.toString());
        print("Error: $error");
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){

          Navigator.pop(context);

        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('Post Job',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color(kmycolor.value),
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
                decoration: InputDecoration(labelText: 'Job Title:'),
              ),


              SizedBox(height: 16.0),
              TextFormField(
                controller: joblocationController,
                decoration: InputDecoration(labelText: 'Job Location:'),
              ),
              SizedBox(height: 16.0),

              DropdownButtonFormField<String>(
                // value: selectedJobTiming,
                decoration: InputDecoration(labelText: 'Select Job Timing'),
                items: [
                  'Full Time',
                  'Part Time',
                  'Remote',
                  // Add more job timing options as needed
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedJobTiming = value ?? '';
                  });
                },
              ),


              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                // value: selectedSalary,
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
                  if (value != null) {
                    setState(() {
                      selectedSalary = value;
                    });
                  }
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

