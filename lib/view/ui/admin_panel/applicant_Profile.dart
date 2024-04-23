import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/ui/admin_panel/pdfview_screen.dart';

class Applicant_Profile extends StatefulWidget {
  final String applicantUid;
  final String jobId;

  const Applicant_Profile({Key? key, required this.applicantUid, required this.jobId}) : super(key: key);

  @override
  State<Applicant_Profile> createState() => _Applicant_ProfileState();
}

class _Applicant_ProfileState extends State<Applicant_Profile> {
  double value = 0;
  Map<String, dynamic>? userData;
  List<String> skillKeys = [];
  late String _selectedAction = 'Select Action';

  String _getFileName(String? filePath) {
    if (filePath == null || filePath.isEmpty) {
      return ''; // Return empty string if filePath is null or empty
    } else {
      // Split the filePath by '?' to get the file name
      List<String> pathSegments = filePath.split('?');
      // Get the first segment after splitting by '?'
      String fileNameWithToken = pathSegments.first;
      // Split the fileNameWithToken by '/' to get the file name
      List<String> fileNameSegments = fileNameWithToken.split('/');
      // Decode the file name to remove any URL encoding
      String decodedFileName = Uri.decodeFull(fileNameSegments.last);
      // Return the decoded file name
      return decodedFileName;
    }
  }

  void handleAction(String jobId, String applicantUid, String action) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(applicantUid)
        .collection('My_Applications')
        .where('jobID', isEqualTo: jobId)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'status': action}).then((_) {
          if (action == 'Accepted') {
            // Update the status of all other applicants for this job to "Rejected"
            FirebaseFirestore.instance
                .collection('Users')
                .where('My_Applications', arrayContains: {'jobID': jobId})
                .get()
                .then((querySnapshot) {
              querySnapshot.docs.forEach((applicantDoc) {
                if (applicantDoc.id != applicantUid) {
                  applicantDoc.reference
                      .collection('My_Applications')
                      .where('jobID', isEqualTo: jobId)
                      .get()
                      .then((applicationQuerySnapshot) {
                    applicationQuerySnapshot.docs.forEach((applicationDoc) {
                      if (applicationDoc['status'] != 'Accepted') {
                        applicationDoc.reference.update({'status': 'Rejected'});
                      }
                    });
                  });
                }
              });

              // Update the applicationStatus in Users_Job collection
              FirebaseFirestore.instance
                  .collection('Users_Job')
                  .doc(jobId)
                  .update({'applicationStatus': action})
                  .then((_) {
                print('Application status updated in Users_Job collection');
              }).catchError((error) {
                print('Error updating application status in Users_Job collection: $error');
              });

              // Remove the job from the Jobs collection when it's accepted
              FirebaseFirestore.instance
                  .collection('Jobs')
                  .doc(jobId)
                  .delete()
                  .then((_) {
                print('Job removed from Jobs collection');
              }).catchError((error) {
                print('Error removing job from Jobs collection: $error');
              });
            }).catchError((error) {
              print('Error updating application status: $error');
            });
          } else if (action == 'Rejected') {
            // Update the applicationStatus in Users_Job collection to "Rejected" when action is "Rejected"
            FirebaseFirestore.instance
                .collection('Users_Job')
                .doc(jobId)
                .update({'applicationStatus': action})
                .then((_) {
              print('Application status updated in Users_Job collection');
            }).catchError((error) {
              print('Error updating application status in Users_Job collection: $error');
            });
          }
        }).catchError((error) {
          print('Error updating application status: $error');
        });
      });
    }).catchError((error) {
      print('Error updating application status: $error');
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            color: Color(kprimary_colors.value),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Custom_AppBar(
            text: "Profile",
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      value == 0 ? value = 1 : value = 0;
                    });
                  },
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 20,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.applicantUid)
                .collection('User_Profile')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text('No data available');
              }

              final documents = snapshot.data!.docs;
              userData = documents.first.data() as Map<String, dynamic>?;
              skillKeys = userData?.keys.where((key) => key.startsWith('Skill')).toList() ?? [];

              return Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          userData?['profileImageUrl'] ?? '',
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Heading(
                            text: userData?['User Name'] ?? '',
                            color: Color(kDark.value),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Color(kDark.value),
                                size: 20,
                              ),
                              ReusableText(
                                text: userData?['User Location'] ?? '',
                                color: Color(kDarkGrey.value),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Color(klightGrey.value),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewerScreen(pdfUrl: userData?['User CV'] ?? ''),
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              width: 80,
                              color: Color(kLight.value),
                              child: const Icon(
                                Icons.picture_as_pdf_rounded,
                                size: 70,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 35,
                              left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Heading(
                                  text: "Resume from JobPortal",
                                  color: Color(kDark.value),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                ReusableText(
                                  text: _getFileName(userData?['User CV']),
                                  color: Color(kDark.value),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Color(klightGrey.value),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 30,
                            width: 30,
                            color: Color(kLight.value),
                            child: const Icon(
                              Icons.email_rounded,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Heading(
                              text: userData?['User Email'] ?? '',
                              color: Color(kDark.value),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Color(klightGrey.value),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Image.asset("Assets/Images/pk.png"),
                          ),
                        ),
                        Heading(
                          text: userData?['User Phone'] ?? '',
                          color: Color(kDark.value),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 320,
                    width: double.infinity,
                    color: Color(klightGrey.value),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Heading(
                            text: "Skills",
                            color: Color(kDark.value),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            child: ListView.builder(
                              itemCount: skillKeys.length,
                              itemBuilder: (context, index) {
                                String key = skillKeys[index];
                                final skill = userData?[key] ?? '';
                                return skill.isNotEmpty
                                    ? Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      skill,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )
                                    : const SizedBox();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          color: Color(kOrange.value),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(child: Text("Accept or Reject the Application",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),

              DropdownButton<String>(
                value: _selectedAction,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedAction = newValue ?? '';
                  });
                  // Perform action based on the selected value
                  if (_selectedAction == 'Accepted' || _selectedAction == 'Rejected') {
                    // Pass all four arguments to handleAction
                    handleAction(widget.jobId, widget.applicantUid, _selectedAction);
                  } else if (_selectedAction == null) {
                    print('Selection is null');
                  } else {
                    print('Invalid action');
                  }
                },
                items: <String>['Select Action', 'Accepted', 'Rejected']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )



            ],
          ),
        ),
      ),
    );
  }
}
