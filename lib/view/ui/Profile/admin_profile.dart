import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_mobile_app/controllers/profile_updateProvider.dart';
import 'package:job_mobile_app/utils/Round_button.dart';
import 'package:job_mobile_app/utils/utils.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/admin_panel/admin_drawer.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:provider/provider.dart';

import '../../../resources/constants/app_colors.dart';


class Admin_profile_details extends StatefulWidget {
  const Admin_profile_details({super.key});

  @override
  State<Admin_profile_details> createState() => _Admin_profile_detailsState();
}

class _Admin_profile_detailsState extends State<Admin_profile_details> {


  File? _image;
  final picker = ImagePicker();
  File? _selectedImage;
  bool isImagePicked = false;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  String? _profileImageUrl;
  String? _filePath;


  TextEditingController nameController = TextEditingController();
  TextEditingController useremailController=TextEditingController();
  TextEditingController phoneController = TextEditingController();



  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void initState() {
    super.initState();
    fetchUserProfileData();
  }


  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        isImagePicked = true;
      });

      debugPrint("Image Picked Successfully");
    } else {
      print("No Image has been picked");
    }
  }

  Future<String> _uploadImage() async {
    try {
      if (_selectedImage == null || !_selectedImage!.existsSync()) {
        print('Selected image is null or does not exist. Cannot upload.');
        return '';
      }

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
      storage.ref().child('admin_images/${DateTime.now()}.jpg');
      await storageReference.putFile(_selectedImage!);
      String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }


  Future<void> _submitDetails() async {
    try {
      print('Submitting user details...');
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentReference userProfileRef = firestore.collection('Admins').doc(user.uid).collection('Admin_Profile').doc(user.uid);

        setState(() {
          isLoading = true; // Start showing circular progress indicator
        });

        Map<String, dynamic> profileData = {
          'name': nameController.text,
          'email': useremailController.text,
          'User Phone': phoneController.text,

        };



        // Upload image if selected
        if (_selectedImage != null) {
          print('Uploading image...');
          String imageUrl = await _uploadImage();
          print('Image uploaded: $imageUrl');
          profileData['profileImageUrl'] = imageUrl;
        }

        // Check if the user profile document already exists
        bool userProfileExists = await userProfileRef.get().then((docSnapshot) => docSnapshot.exists);
        print('User profile exists: $userProfileExists');

        if (userProfileExists) {
          // Update user profile data if document exists
          await userProfileRef.update(profileData);
        } else {
          // Create new user profile document if it doesn't exist
          await userProfileRef.set(profileData);
        }

        setState(() {
          isLoading = false; // Stop showing circular progress indicator
        });

        // Show success message
        Utils().toastMessage("Admin Loggedin successfully");
        Get.to(admin_main_page());
        print('User details updated successfully');
      }
    } catch (e) {
      print('Error submitting user details: $e');
      setState(() {
        isLoading = false; // Stop showing circular progress indicator
      });
    }
  }


  Future<void> fetchUserProfileData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Admins');
        DocumentReference userDocRef = usersCollection.doc(user.uid);
        CollectionReference userProfileCollection = userDocRef.collection('Admin_Profile');

        QuerySnapshot userProfileDocs = await userProfileCollection.get();

        if (userProfileDocs.docs.isNotEmpty) {
          // Assuming there's only one document for the user profile
          DocumentSnapshot userProfileDoc = userProfileDocs.docs.first;

          Map<String, dynamic> userData = userProfileDoc.data() as Map<String, dynamic>;

          setState(() {

            phoneController.text = userData['User Phone'] ?? '';
            nameController.text = userData['name'] ?? '';
            useremailController.text= userData['email'] ?? '';


            // Check if profileImageUrl exists and update _profileImageUrl
            _profileImageUrl = userData['profileImageUrl'];

            // Set isImagePicked to true if _profileImageUrl is not null or empty
            isImagePicked = _profileImageUrl != null && _profileImageUrl!.isNotEmpty;


          });
        }

        // Retrieve user's name and email from the 'Users' collection
        DocumentSnapshot userDoc = await userDocRef.get();
        if (userDoc.exists) {
          String userName = userDoc['name'];
          nameController.text = userName;

          String useremail = userDoc['email'];
          useremailController.text = useremail;
        }
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }







  @override
  Widget build(BuildContext context) {
    return Consumer<changeprofileNotifier>(
      builder: (context,changeprofileNotifier,child ){

        return  Scaffold(


          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Heading(
                          text: "Personal Details",
                          color: Color(kDark.value),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                
                        GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(kmycolor.value),
                            child: isImagePicked
                                ? Icon(
                              Icons.check,
                              color: Color(kLight.value),
                            )
                                : Icon(
                              Icons.photo_library_outlined,
                              color: Color(kLight.value),
                            ),
                          ),
                        ),
                
                      ],
                    ),
                
                    SizedBox(height: 20,),
                    Form(
                        key: _formkey,
                        child: Column(
                
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(kGrey.value),
                                hintText: 'User Name',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "User Name cannot be empty";
                                }
                
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                
                            TextFormField(
                              controller: useremailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(kGrey.value),
                                hintText: ' User Email',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email cannot be empty";
                                }
                                if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]")
                                    .hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                
                
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(kGrey.value),
                                hintText: 'Enter Phone Number',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Location cannot be empty";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                
                
                          ],
                        )),
                
                
                    Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: RoundButton(
                        title: 'Submit Information',
                        loading: changeprofileNotifier.isLoading,
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            changeprofileNotifier.isLoading = true;
                            await _submitDetails();
                            changeprofileNotifier.isLoading = false;
                          }
                        },
                      ),
                    ),
                
                
                
                  ],
                ),
              ),
            ),
          ),


        );
      }

    );
  }
}
