import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_mobile_app/controllers/profile_updateProvider.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/utils/Round_button.dart';
import 'package:job_mobile_app/utils/utils.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';
import 'package:provider/provider.dart';

class Profile_Details extends StatefulWidget {
  const Profile_Details({super.key});

  @override
  State<Profile_Details> createState() => _Profile_DetailsState();
}

class _Profile_DetailsState extends State<Profile_Details> {
  File? _image;
  final picker = ImagePicker();
  final _Formkey = GlobalKey<FormState>();
  final _formkey = GlobalKey<FormState>();
  File? _selectedImage;
  bool isLoading = false;
  bool isImagePicked = false;
  bool _profileLoading = false;
  String? _profileImageUrl;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController skillOneController = TextEditingController();
  TextEditingController skillTwoController = TextEditingController();
  TextEditingController skillThreeController = TextEditingController();
  TextEditingController skillFourController = TextEditingController();
  TextEditingController skillFiveController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController expertiesController = TextEditingController();

  @override
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
      storage.ref().child('profile_images/${DateTime.now()}.jpg');
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
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');
        DocumentReference userDocRef = usersCollection.doc(user.uid);
        CollectionReference userProfileCollection = userDocRef.collection('User_Profile');

        Map<String, dynamic> profileData = {
          'User Name': nameController.text,
          'Your Expertise': expertiesController.text,
          'User Location': locationController.text,
          'User Phone': phoneController.text,
          'Skill one': skillOneController.text,
          'Skill two': skillTwoController.text,
          'Skill three': skillThreeController.text,
          'Skill four': skillFourController.text,
          'Skill five': skillFiveController.text,
        };

        // Upload image if selected
        if (_selectedImage != null) {
          String imageUrl = await _uploadImage();
          profileData['profileImageUrl'] = imageUrl;
        }

        // Check if user already has a profile in the subcollection
        QuerySnapshot existingProfile = await userProfileCollection.get();
        if (existingProfile.docs.isNotEmpty) {
          // Update existing profile data
          await userProfileCollection.doc(existingProfile.docs.first.id).update(profileData);
          print('User profile updated successfully');
        } else {
          // Add new profile data
          await userProfileCollection.add(profileData);
          print('New user profile added successfully');
        }

        Utils().toastMessage("Profile details submitted successfully");
        Get.to(drawer_animated());
      } else {
        print('User not authenticated. Unable to submit details.');
      }
    } catch (e) {
      print('Error submitting user details: $e');
    }
  }

  Future<void> fetchUserProfileData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');
        DocumentReference userDocRef = usersCollection.doc(user.uid);
        CollectionReference userProfileCollection = userDocRef.collection('User_Profile');

        QuerySnapshot userProfileDocs = await userProfileCollection.get();

        if (userProfileDocs.docs.isNotEmpty) {
          // Assuming there's only one document for the user profile
          DocumentSnapshot userProfileDoc = userProfileDocs.docs.first;

          Map<String, dynamic> userData = userProfileDoc.data() as Map<String, dynamic>;

          setState(() {
            locationController.text = userData['User Location'] ?? '';
            expertiesController.text = userData['Your Expertise'] ?? '';
            phoneController.text = userData['User Phone'] ?? '';
            skillOneController.text = userData['Skill one'] ?? '';
            skillTwoController.text = userData['Skill two'] ?? '';
            skillThreeController.text = userData['Skill three'] ?? '';
            skillFourController.text = userData['Skill four'] ?? '';
            skillFiveController.text = userData['Skill five'] ?? '';

            // Check if profileImageUrl exists and update _profileImageUrl
            _profileImageUrl = userData['profileImageUrl'];

            // Set isImagePicked to true if _profileImageUrl is not null or empty
            isImagePicked = _profileImageUrl != null && _profileImageUrl!.isNotEmpty;
          });
        }

        // Retrieve user's name from the 'Users' collection
        DocumentSnapshot userDoc = await userDocRef.get();
        if (userDoc.exists) {
          String userName = userDoc['name'];
          nameController.text = userName;
        }
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<changeprofileNotifier>(
      builder: (context, changeprofileNotifier, child) {
        return Scaffold(
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
                          fontSize: 35,
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
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _Formkey,
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
                            controller: expertiesController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(kGrey.value),
                              hintText: 'Your Expertise',
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
                            controller: locationController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(kGrey.value),
                              hintText: 'Enter Location',
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Heading(
                            text: "Professional Details",
                            color: Color(kDark.value),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: skillOneController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(kGrey.value),
                              hintText: 'Professional Skills',
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
                                return "Skill cannot be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: skillTwoController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(kGrey.value),
                              hintText: 'Professional Skills',
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
                                return "Skill cannot be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: skillThreeController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(kGrey.value),
                              hintText: 'Professional Skills',
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
                                return "Skill cannot be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: skillFourController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(kGrey.value),
                              hintText: 'Professional Skills',
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
                                return "Skill cannot be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: skillFiveController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(kGrey.value),
                              hintText: 'Professional Skills',
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
                                return "Skill cannot be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundButton(
                      title: 'Update Information',
                      loading: changeprofileNotifier.isLoading,
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          changeprofileNotifier.isLoading = true;
                          await _submitDetails();
                          changeprofileNotifier.isLoading = false;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
