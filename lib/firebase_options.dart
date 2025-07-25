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
    apiKey: 'AIzaSyCZ_OklTdN0ANnt91pm6Nk__tf_rzQks5U',
    appId: '1:746728769634:web:79bd36c0cf176c30a8693b',
    messagingSenderId: '746728769634',
    projectId: 'wasil-shop-2025',
    authDomain: 'wasil-shop-2025.firebaseapp.com',
    storageBucket: 'wasil-shop-2025.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA46wg-ITr1lMZ72aBA22cj7kZYfOUgHsY',
    appId: '1:746728769634:android:0ce4a47398b000a2a8693b',
    messagingSenderId: '746728769634',
    projectId: 'wasil-shop-2025',
    storageBucket: 'wasil-shop-2025.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDusoY0rj59SyYDC5Xb9i7v236CpZcmi4',
    appId: '1:746728769634:ios:218ee6923f65f398a8693b',
    messagingSenderId: '746728769634',
    projectId: 'wasil-shop-2025',
    storageBucket: 'wasil-shop-2025.firebasestorage.app',
    iosBundleId: 'com.example.productListApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDusoY0rj59SyYDC5Xb9i7v236CpZcmi4',
    appId: '1:746728769634:ios:218ee6923f65f398a8693b',
    messagingSenderId: '746728769634',
    projectId: 'wasil-shop-2025',
    storageBucket: 'wasil-shop-2025.firebasestorage.app',
    iosBundleId: 'com.example.productListApp',
  );

}