import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViwe extends StatefulWidget {
  const LoginViwe({super.key});

  @override
  State<LoginViwe> createState() => _LoginViweState();
}

class _LoginViweState extends State<LoginViwe> {
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
        title: const Text("Login", style: TextStyle(color: Colors.white, ),),
        backgroundColor: Colors.green.shade400,
      ),
        body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                      );
                      print(credential);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  child: const Text("Login")
              ),

              TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil('/registrion', (Route route) => false);
                  },
                  child: const Text("Not register get? Register hear")
              ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil('/verify-email', (Route route) => false);
                  },
                  child: const Text("Verify email")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
