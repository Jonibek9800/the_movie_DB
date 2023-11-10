import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
          child: Text(
        "Hello I am Sing Up",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue,),
      )),
    );
  }
}
