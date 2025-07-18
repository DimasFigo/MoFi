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
    apiKey: 'AIzaSyAHUVtWFgialxB7k1IvJIQeSRURD61Wn3I',
    appId: '1:332681413885:web:6492b883eb64a1ddf76a94',
    messagingSenderId: '332681413885',
    projectId: 'mofi-388e9',
    authDomain: 'mofi-388e9.firebaseapp.com',
    storageBucket: 'mofi-388e9.firebasestorage.app',
    measurementId: 'G-27TJ9WRK9V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0SrKU-wDX2FhS1eSB5d4Sss4bWhqI0vQ',
    appId: '1:332681413885:android:2221b8228225482ff76a94',
    messagingSenderId: '332681413885',
    projectId: 'mofi-388e9',
    storageBucket: 'mofi-388e9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-OMCXv-VBYMBe11pkhKxkAthIbTz0oDY',
    appId: '1:332681413885:ios:5e0ce2de919d5836f76a94',
    messagingSenderId: '332681413885',
    projectId: 'mofi-388e9',
    storageBucket: 'mofi-388e9.firebasestorage.app',
    iosBundleId: 'com.example.mofi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-OMCXv-VBYMBe11pkhKxkAthIbTz0oDY',
    appId: '1:332681413885:ios:5e0ce2de919d5836f76a94',
    messagingSenderId: '332681413885',
    projectId: 'mofi-388e9',
    storageBucket: 'mofi-388e9.firebasestorage.app',
    iosBundleId: 'com.example.mofi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAHUVtWFgialxB7k1IvJIQeSRURD61Wn3I',
    appId: '1:332681413885:web:db2d7aa013de8b4df76a94',
    messagingSenderId: '332681413885',
    projectId: 'mofi-388e9',
    authDomain: 'mofi-388e9.firebaseapp.com',
    storageBucket: 'mofi-388e9.firebasestorage.app',
    measurementId: 'G-9JLFM9F1R9',
  );

}