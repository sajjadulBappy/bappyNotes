import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notesproject/viwes/login_viwe.dart';
import 'package:notesproject/viwes/registration_viwe.dart';
import 'package:notesproject/viwes/verify_email.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyD2D7uYMP3HzQlqPDq1dZit24I6QnFIgLs",
        authDomain: "notesproject-1ee1f.firebaseapp.com",
        projectId: "notesproject-1ee1f",
        storageBucket: "notesproject-1ee1f.appspot.com",
        messagingSenderId: "758333746103",
        appId: "1:758333746103:web:cf3376351c0463a02fd632"
    ));
  }else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
      routes: {
        "/login": (context)=> const LoginViwe(),
        "/registrion": (context)=> const Registrion(),
        "/verify-email": (context)=> const VerifyEmail(),
      },
    );
  }
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<FirebaseApp>(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error initializing Firebase');
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              final user = FirebaseAuth.instance.currentUser;

              if(user != null){
                if(user.emailVerified ?? false){
                  print(">>>You are a verified user");
                }else{
                  return const VerifyEmail();
                }
              }else{
                return const LoginViwe();
              }

              return const Text("done");
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return const CircularProgressIndicator();
          },

        ),
      ),
    );
  }
}







