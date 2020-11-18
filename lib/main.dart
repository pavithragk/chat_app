import 'package:chat_app_firebase/screens/auth_screen.dart';
import 'package:chat_app_firebase/screens/chat_screen.dart';
import 'package:chat_app_firebase/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'Flutter Chat',
            theme: ThemeData(
                primarySwatch: Colors.pink,
                accentColor: Colors.deepPurple,
                //  accentColorBrightness:
                backgroundColor: Colors.pink,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )),
            // home: ChatScreen());
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return ChatScreen();
                  }
                  return AuthScreen();
                }),
          );
        });
  }
}
