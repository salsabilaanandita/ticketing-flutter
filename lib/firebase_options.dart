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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDifvyqPO_QXckScU4ULT6mnO2Qy7kUtJY',
    appId: '1:802713114725:android:132d2c79ba463be375ce8c',
    messagingSenderId: '802713114725',
    projectId: 'ticketing-app-f5770',
    storageBucket: 'ticketing-app-f5770.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjWmHhDZvRGU17ysdk3WNMNwxz5PFFLeI',
    appId: '1:802713114725:ios:b08ac88a2007c09b75ce8c',
    messagingSenderId: '802713114725',
    projectId: 'ticketing-app-f5770',
    storageBucket: 'ticketing-app-f5770.firebasestorage.app',
    iosBundleId: 'com.example.appTicketing',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAWvakp8bhJuHgBCS8o4Br8vMIr-uuR8Xo',
    appId: '1:802713114725:web:aca349b56225a38f75ce8c',
    messagingSenderId: '802713114725',
    projectId: 'ticketing-app-f5770',
    authDomain: 'ticketing-app-f5770.firebaseapp.com',
    storageBucket: 'ticketing-app-f5770.firebasestorage.app',
    measurementId: 'G-NCSXBMX9SZ',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAWvakp8bhJuHgBCS8o4Br8vMIr-uuR8Xo',
    appId: '1:802713114725:web:ff739502e4ea640875ce8c',
    messagingSenderId: '802713114725',
    projectId: 'ticketing-app-f5770',
    authDomain: 'ticketing-app-f5770.firebaseapp.com',
    storageBucket: 'ticketing-app-f5770.firebasestorage.app',
    measurementId: 'G-1PY9DJ9MS6',
  );

}