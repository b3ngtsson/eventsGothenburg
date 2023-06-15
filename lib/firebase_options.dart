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
    apiKey: 'AIzaSyDEhxiclPqns08D4hY6cXPJCWjyL7_9rh0',
    appId: '1:1072942649857:web:95e0a1638c691af31c6600',
    messagingSenderId: '1072942649857',
    projectId: 'eventsgbg-5654c',
    authDomain: 'eventsgbg-5654c.firebaseapp.com',
    storageBucket: 'eventsgbg-5654c.appspot.com',
    measurementId: 'G-9PYC8975EW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzP9LVEhc2GsmVY8k0upoKBaLAD6KwYG0',
    appId: '1:1072942649857:android:6b5ad5024eb0afe51c6600',
    messagingSenderId: '1072942649857',
    projectId: 'eventsgbg-5654c',
    storageBucket: 'eventsgbg-5654c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2fW55FJ5F8Tlx_WkI9fFNYmpGlnCP_fc',
    appId: '1:1072942649857:ios:29cb057083410dd21c6600',
    messagingSenderId: '1072942649857',
    projectId: 'eventsgbg-5654c',
    storageBucket: 'eventsgbg-5654c.appspot.com',
    iosClientId: '1072942649857-d3uhq5dr3v09lv5samt9ahv51jjvp92o.apps.googleusercontent.com',
    iosBundleId: 'com.example.eventsgbg',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2fW55FJ5F8Tlx_WkI9fFNYmpGlnCP_fc',
    appId: '1:1072942649857:ios:4cece7485c08b1a01c6600',
    messagingSenderId: '1072942649857',
    projectId: 'eventsgbg-5654c',
    storageBucket: 'eventsgbg-5654c.appspot.com',
    iosClientId: '1072942649857-prhfetlimekplu266pgug2hserart02m.apps.googleusercontent.com',
    iosBundleId: 'com.example.eventsgbg.RunnerTests',
  );
}