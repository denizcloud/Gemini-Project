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
    apiKey: 'AIzaSyB_zt4z_Tmi4zKYVI5-tgkbTR91p2c57iE',
    appId: '1:263670736389:web:9f3ef245a2422efd409e6c',
    messagingSenderId: '263670736389',
    projectId: 'authorizer-e6ee1',
    authDomain: 'authorizer-e6ee1.firebaseapp.com',
    databaseURL: 'https://authorizer-e6ee1-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'authorizer-e6ee1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6sRv8zao-hX7M6LMqZ7IHomdaAetrieY',
    appId: '1:263670736389:android:5918319a2fc15f79409e6c',
    messagingSenderId: '263670736389',
    projectId: 'authorizer-e6ee1',
    databaseURL: 'https://authorizer-e6ee1-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'authorizer-e6ee1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdtDLvNnVGNOfDStlOPmzRaAFYk8jZv14',
    appId: '1:263670736389:ios:bf6fcd98821563cc409e6c',
    messagingSenderId: '263670736389',
    projectId: 'authorizer-e6ee1',
    databaseURL: 'https://authorizer-e6ee1-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'authorizer-e6ee1.appspot.com',
    iosClientId: '263670736389-tvir53bnbqcqgvm1c0tqn4mfamo28oaj.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsAppEmpty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdtDLvNnVGNOfDStlOPmzRaAFYk8jZv14',
    appId: '1:263670736389:ios:bf6fcd98821563cc409e6c',
    messagingSenderId: '263670736389',
    projectId: 'authorizer-e6ee1',
    databaseURL: 'https://authorizer-e6ee1-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'authorizer-e6ee1.appspot.com',
    iosClientId: '263670736389-tvir53bnbqcqgvm1c0tqn4mfamo28oaj.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsAppEmpty',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB_zt4z_Tmi4zKYVI5-tgkbTR91p2c57iE',
    appId: '1:263670736389:web:178dbf5e2751f776409e6c',
    messagingSenderId: '263670736389',
    projectId: 'authorizer-e6ee1',
    authDomain: 'authorizer-e6ee1.firebaseapp.com',
    databaseURL: 'https://authorizer-e6ee1-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'authorizer-e6ee1.appspot.com',
  );
}