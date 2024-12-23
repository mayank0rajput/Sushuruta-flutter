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
    apiKey: 'AIzaSyCVBwkOMv0t9WB6ZgL252t6AKY8E9RcZIs',
    appId: '1:758451723191:web:f4d33ff16ae1cec45ce632',
    messagingSenderId: '758451723191',
    projectId: 'ecommerce-ef479',
    authDomain: 'ecommerce-ef479.firebaseapp.com',
    storageBucket: 'ecommerce-ef479.firebasestorage.app',
    measurementId: 'G-KPXZLGBRVG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9yRMLFyE7PHY8AJaALuJIfOGqFuVfik4',
    appId: '1:758451723191:android:a64e6bf584fc48ff5ce632',
    messagingSenderId: '758451723191',
    projectId: 'ecommerce-ef479',
    storageBucket: 'ecommerce-ef479.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzupV9Hoz-skq-iReHN_szbTWSGFpgDfQ',
    appId: '1:758451723191:ios:36c127f6d9e9dcdb5ce632',
    messagingSenderId: '758451723191',
    projectId: 'ecommerce-ef479',
    storageBucket: 'ecommerce-ef479.firebasestorage.app',
    androidClientId: '758451723191-0vbsscif01recf1dqge447jfo8ate29g.apps.googleusercontent.com',
    iosClientId: '758451723191-l52g8pcvnqq095vjuluoavv73pelnq9d.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

}