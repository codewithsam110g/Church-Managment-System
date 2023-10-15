# Church Management System

This project is a Flutter app that allows a church to view and maintain their members and membership, keeping track of when and who are coming, etc. It uses Firebase tools like auth and real-time database and also Google sign-in to sign in clients.

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository to your local machine.
2. Install and initialize the Firebase SDKs for Flutter if you haven't already done so.
3. Add Firebase Authentication to your app by running the following command from the root of your Flutter project: `flutter pub add firebase_auth`.
4. Enable Email/Password sign-in and any other identity providers you want for your app on the Sign-in Method page in the Firebase Authentication section.
5. Ensure the "Google" sign-in provider is enabled on the Firebase Console.
6. Install the official `google_sign_in` plugin by running the following command: `flutter pub add google_sign_in`.
7. Import the plugin in your Dart code: `import 'package:google_sign_in/google_sign_in.dart';`.

## Authentication

Firebase Auth provides many methods and utilities to enable you to integrate secure authentication into your new or existing Flutter application. In many cases, you will need to know about the authentication state of your user, such as whether they're logged in or logged out. Firebase Auth enables you to subscribe in real time to this state via a stream.

### Google Sign-In

To implement Google Sign-In using Firebase authentication, follow these steps:

1. Create a new Firebase project.
2. Enable the Google sign-in provider on the Firebase Console.
3. Install the official `google_sign_in` plugin.
4. Trigger the sign-in flow and create a new credential.
5. Authenticate users with Google Sign-In on the Android and iOS platforms.
6. Modify the `signInWithPopup()` method on the FirebaseAuth instance to use Google Sign-In on the web platform.

For more information on how to implement Google Sign-In using Firebase authentication, refer to the following resources:

- [Firebase Authentication with Flutter](https://firebase.google.com/docs/auth/flutter/start)
- [Google Sign-In & Firebase Authentication Using Flutter](https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter/)
- [How to Use Google Sign-in With Firebase in Flutter](https://www.youtube.com/watch?v=MRb_2Kg0nRI)
- [Google Sign-in with Flutter using Firebase authentication](https://medium.flutterdevs.com/google-sign-in-with-flutter-8960580dec96)

## Real-time Database

This project uses Firebase Real-time Database to store and sync data in real-time. To get started with Firebase Real-time Database, follow these steps:

1. Create a Firebase project.
2. Add Firebase to your app by following the instructions in the Firebase Console.
3. Initialize the Firebase Real-time Database SDK in your app.
4. Write data to the database.
5. Read data from the database.

For more information on how to use Firebase Real-time Database, refer to the following resources:

- [Firebase Real-time Database with Flutter](https://firebase.flutter.dev/docs/database/usage/)
- [Flutter Firebase Realtime Database CRUD Operation](https://www.geeksforgeeks.org/flutter-firebase-realtime-database-crud-operation/)

## Contributing

Contributions are welcome! If you find any issues or have any suggestions, please feel free to open an issue or a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
