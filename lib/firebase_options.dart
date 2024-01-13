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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBQNunFOc8EPFIhP21qqg2BGEfYEgf_kj8',
    appId: '1:1041771471193:web:52c4cf1d7be467d0acec48',
    messagingSenderId: '1041771471193',
    projectId: 'flutter-c5149',
    authDomain: 'flutter-c5149.firebaseapp.com',
    storageBucket: 'flutter-c5149.appspot.com',
    measurementId: 'G-Q7QW6CCND1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgqvO4ZF2Mr4Gvkax2aAt4p0MfuXRoVGY',
    appId: '1:1041771471193:android:001620acf3e5cdc4acec48',
    messagingSenderId: '1041771471193',
    projectId: 'flutter-c5149',
    storageBucket: 'flutter-c5149.appspot.com',
  );
}
// TODO Implement this library.