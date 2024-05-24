import "dart:math";

import "package:firebase_messaging/firebase_messaging.dart";
import 'package:app_settings/app_settings.dart';
import "package:flutter/foundation.dart";
import"package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";

class Notification_Services{

  FirebaseMessaging messaging=FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin=FlutterLocalNotificationsPlugin();



  void Request_NotificationPermission()async{

      NotificationSettings settings= await messaging.requestPermission(
          alert:true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true);


      if(settings.authorizationStatus==AuthorizationStatus.authorized){
        debugPrint("User Granted the Permission");

      }else if(settings.authorizationStatus==AuthorizationStatus.provisional){

        debugPrint("User Granted the Provisional Permission");

      }else{

        AppSettings.openAppSettings();
        debugPrint("Permission Denied");
      }

  }
  Future<String>getDeviceToken()async{

    String?token=await messaging.getToken();
    return token!;
  }
//The token may expired then use this to Refresh the token
  void isTokenRefresh()async{

    messaging.onTokenRefresh.listen((event) {

      event.toString();
    });
  }

  void firebaseintit(){
     FirebaseMessaging.onMessage.listen((message) {

    if(kDebugMode){
      debugPrint(message.notification!.title.toString());
      debugPrint(message.notification!.body.toString());

    }
    ShowNotification(message);
     });



  }
  //Show notification Plugin

   Future <void> ShowNotification(RemoteMessage message)async {
   AndroidNotificationChannel channel=AndroidNotificationChannel(
       Random.secure().nextInt(1000).toString(),
       'High Importance Message',
     importance: Importance.max
   );
    AndroidNotificationDetails _notificationDetails=AndroidNotificationDetails(

        channel.id.toString(),
        channel.name.toString(),
        channelDescription: 'Here is Channel Description',
        importance:Importance.high,
      priority: Priority.high,
        ticker: 'ticker'
    );
    NotificationDetails notificationDetails=const NotificationDetails(

      // android: androidNotificationDetails,
    );



  }

  //Show Notification When App is Active for only Android
  void initLocationNotification(BuildContext, RemoteMessage message)async{
    var androidinitialization=const AndroidInitializationSettings('@mipmap/ic_launcger.');
    var initializationsetting=InitializationSettings(

      android: androidinitialization,
    );

    await _localNotificationsPlugin.initialize(
    initializationsetting,
      onDidReceiveNotificationResponse: (payload){

      }
    );

    //now if message recieved here then we should show the go to firebaseinit()
  }


}