import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/utils/utils.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/custom_outline_button.dart';
import 'package:job_mobile_app/view/ui/device_manag/Device_info.dart';
import 'package:intl/intl.dart';
import 'package:job_mobile_app/view/ui/drawer/animated_drawer.dart';

class DeviceManagementPage extends StatefulWidget {
  const DeviceManagementPage({Key? key});

  @override
  State<DeviceManagementPage> createState() => _DeviceManagementPageState();
}

class _DeviceManagementPageState extends State<DeviceManagementPage> {
  void signOutFromDevice(DocumentSnapshot deviceSnapshot) async {
    try {
      var documentId = deviceSnapshot.id;

      // Delete the document from Firestore based on the user role
      if (await isAdmin()) {
        await FirebaseFirestore.instance
            .collection(
            'Admins/${FirebaseAuth.instance.currentUser!.uid}/admin_logins')
            .doc(documentId)
            .delete();
      } else {
        await FirebaseFirestore.instance
            .collection(
            'Users/${FirebaseAuth.instance.currentUser!.uid}/user_logins')
            .doc(documentId)
            .delete();
      }

      // Sign out the user
      await FirebaseAuth.instance.signOut();

      Utils().toastMessage('Signout Successfully');
    } catch (error) {
      Utils().toastMessage('Error occurred during sign out: $error');
    }
  }

  void checkAndAddDevice(dynamic deviceDetails) async {
    try {
      // Determine the collection name based on the user's role
      String collectionName = await getCollectionName();

      // Check if the device already exists in the collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('deviceName', isEqualTo: deviceDetails['deviceName'])
          .where('ipAddress', isEqualTo: deviceDetails['ipAddress'])
          .get();

      // If no duplicate documents are found, add a new document
      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection(collectionName)
            .add(deviceDetails);
      } else {
        // Device already exists, update the existing document
        DocumentSnapshot existingDoc = querySnapshot.docs.first;
        await existingDoc.reference.update(deviceDetails);
        print('Device already exists. Document updated.');
      }
    } catch (error) {
      print('Error checking and adding device: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            color: Color(kprimary_colors.value),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Custom_AppBar(
            text: "Device Management",
            child: IconButton(
              onPressed: () {
                Get.to(drawer_animated());
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You are logged in to your account on these devices",
                    style: TextStyle(
                      color: Color(kDark.value),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: FutureBuilder<String>(
                      future: getCollectionName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                'No User Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ));
                        } else if (snapshot.hasData) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(snapshot.data!)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Center(
                                    child: Text(
                                      'Error: ${snapshot.error}',
                                    ));
                              } else if (snapshot.hasData) {
                                List<QueryDocumentSnapshot> docs =
                                    snapshot.data!.docs;
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      for (var doc in docs)
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 30),
                                          child: Device_Info(
                                            date: _formatDate(
                                                doc['loginTime']),
                                            device: doc['deviceName']
                                                .toString(),
                                            ipAddress: doc['ipAddress']
                                                .toString(),
                                            onSignOut: () =>
                                                signOutFromDevice(doc),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(child: Text('No data available'));
                              }
                            },
                          );
                        } else {
                          return Center(
                              child: Text('No collection name available'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) {
      return '';
    }

    // Convert timestamp to DateTime
    DateTime dateTime = (timestamp as Timestamp).toDate();

    // Format DateTime object to "Month day, year at hour:minute AM/PM" format
    String formattedDate =
    DateFormat('MMMM d, yyyy \'at\' h:mm a').format(dateTime);

    return formattedDate;
  }

  Future<String> getCollectionName() async {
    // Determine if the current user is admin
    bool isAdmin = await checkAdminStatus();

    // Determine collection name based on user role
    if (isAdmin) {
      // If user is admin, retrieve data from 'Admins' collection
      return 'Admins/${FirebaseAuth.instance.currentUser!.uid}/admin_logins';
    } else {
      // If user is not admin, retrieve data from 'Users' collection
      return 'Users/${FirebaseAuth.instance.currentUser!.uid}/user_logins';
    }
  }

  Future<bool> isAdmin() async {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if the user exists and has the 'isAdmin' custom claim set to true
    if (currentUser != null && currentUser.uid != null) {
      final tokenResult = await currentUser.getIdTokenResult();
      return tokenResult.claims?['isAdmin'] ?? false;
    }

    // Return false if user is null or UID is null
    return false;
  }

  Future<bool> checkAdminStatus() async {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if the user exists and has the 'isAdmin' custom claim set to true
    if (currentUser != null && currentUser.uid != null) {
      final tokenResult = await currentUser.getIdTokenResult();
      return tokenResult.claims?['isAdmin'] ?? false;
    }

    // Return false if user is null or UID is null
    return false;
  }
}
