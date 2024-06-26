// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAmn35E2nDV9-ey3hkolMijGMx4guCjErA',
    appId: '1:148254027825:web:2dc3147c9186dc7568a510',
    messagingSenderId: '148254027825',
    projectId: 'job-portal-app-c92da',
    authDomain: 'job-portal-app-c92da.firebaseapp.com',
    storageBucket: 'job-portal-app-c92da.appspot.com',
    measurementId: 'G-JQYNGN180L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeQmZJSnBbVlPAhe9BE_lVMgEKoBofW6Y',
    appId: '1:148254027825:android:994346371fe176b668a510',
    messagingSenderId: '148254027825',
    projectId: 'job-portal-app-c92da',
    storageBucket: 'job-portal-app-c92da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgUD_i0YpGD6zqmp3GFiwzVfsQ_7pHubA',
    appId: '1:148254027825:ios:fc3fdfb21ffc8a3568a510',
    messagingSenderId: '148254027825',
    projectId: 'job-portal-app-c92da',
    storageBucket: 'job-portal-app-c92da.appspot.com',
    iosBundleId: 'com.example.jobMobileApp',
  );
}
