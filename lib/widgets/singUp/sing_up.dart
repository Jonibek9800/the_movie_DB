import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
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
