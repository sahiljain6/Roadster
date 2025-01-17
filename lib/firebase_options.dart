// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAYuG7hqlwO9m35IyvDdygDDTkAdzlkUaM',
    appId: '1:797000051802:web:ab84ac4e1f720de9593c63',
    messagingSenderId: '797000051802',
    projectId: 'shores-584cf',
    authDomain: 'shores-584cf.firebaseapp.com',
    databaseURL: 'https://shores-584cf-default-rtdb.firebaseio.com',
    storageBucket: 'shores-584cf.appspot.com',
    measurementId: 'G-9L70J3BF6E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFEeTnRnwB55zxLZc0i2-Yfgy4GOSXBLw',
    appId: '1:797000051802:android:9166601ce54c4368593c63',
    messagingSenderId: '797000051802',
    projectId: 'shores-584cf',
    databaseURL: 'https://shores-584cf-default-rtdb.firebaseio.com',
    storageBucket: 'shores-584cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxYxtAjr2lPd4nHjUnA8nFgFh04IigUso',
    appId: '1:797000051802:ios:c2f8e9778f0809a9593c63',
    messagingSenderId: '797000051802',
    projectId: 'shores-584cf',
    databaseURL: 'https://shores-584cf-default-rtdb.firebaseio.com',
    storageBucket: 'shores-584cf.appspot.com',
    iosBundleId: 'com.example.roadster',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxYxtAjr2lPd4nHjUnA8nFgFh04IigUso',
    appId: '1:797000051802:ios:c2f8e9778f0809a9593c63',
    messagingSenderId: '797000051802',
    projectId: 'shores-584cf',
    databaseURL: 'https://shores-584cf-default-rtdb.firebaseio.com',
    storageBucket: 'shores-584cf.appspot.com',
    iosBundleId: 'com.example.roadster',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAYuG7hqlwO9m35IyvDdygDDTkAdzlkUaM',
    appId: '1:797000051802:web:ef7bb0ccbdaa8632593c63',
    messagingSenderId: '797000051802',
    projectId: 'shores-584cf',
    authDomain: 'shores-584cf.firebaseapp.com',
    databaseURL: 'https://shores-584cf-default-rtdb.firebaseio.com',
    storageBucket: 'shores-584cf.appspot.com',
    measurementId: 'G-TL6YWQNNDD',
  );
}
