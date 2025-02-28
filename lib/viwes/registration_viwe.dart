import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Registrion extends StatefulWidget {
  const Registrion({super.key});

  @override
  State<Registrion> createState() => _RegistrionState();
}

class _RegistrionState extends State<Registrion> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration", style: TextStyle(color: Colors.white, ),),
        backgroundColor: Colors.green.shade400,
      ),
      body: Center(
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //email text field
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Enter your email address",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
      
                    //password text field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
      
                    TextButton(
                        onPressed: () async{
                          try {
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print('The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text("Registration")
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route route) => false);
                        },
                        child: const Text("You have all ready register get? Login hear")
                    ),
                  ],
                );
              }
      
              // Otherwise, show something whilst waiting for initialization to complete
              return const Text("Loading...");
            },
      
          ),
        ),
      ),
    );
  }
}