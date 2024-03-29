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
        return macos;
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
    apiKey: 'AIzaSyAYeI5I-OMuiZtXw0QNCbHZo2-raPcyPSM',
    appId: '1:26137335788:web:e4289b3801494f0108d2c9',
    messagingSenderId: '26137335788',
    projectId: 'istore-5ffbc',
    authDomain: 'istore-5ffbc.firebaseapp.com',
    storageBucket: 'istore-5ffbc.appspot.com',
    measurementId: 'G-TBN7DWHYBX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAax4rdtF_zvUoYorZaqpr8PEVk0oXXZo',
    appId: '1:26137335788:android:29bddbf525f59aa008d2c9',
    messagingSenderId: '26137335788',
    projectId: 'istore-5ffbc',
    storageBucket: 'istore-5ffbc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIgCbRbOE_BximNDDRlVGF-VLN43npI_I',
    appId: '1:26137335788:ios:49b1b23539d4811f08d2c9',
    messagingSenderId: '26137335788',
    projectId: 'istore-5ffbc',
    storageBucket: 'istore-5ffbc.appspot.com',
    iosClientId: '26137335788-64i9mks4vidk2bi94b2glhg6rg0e9du1.apps.googleusercontent.com',
    iosBundleId: 'com.example.iStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIgCbRbOE_BximNDDRlVGF-VLN43npI_I',
    appId: '1:26137335788:ios:49b1b23539d4811f08d2c9',
    messagingSenderId: '26137335788',
    projectId: 'istore-5ffbc',
    storageBucket: 'istore-5ffbc.appspot.com',
    iosClientId: '26137335788-64i9mks4vidk2bi94b2glhg6rg0e9du1.apps.googleusercontent.com',
    iosBundleId: 'com.example.iStore',
  );
}
