import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginForm();
  }
}

class _LoginForm extends State<LoginForm> {

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 114,
            ),
            const SizedBox(height: 40),
            TextFormField(),
            TextFormField(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: (){}, 
                child: const Text('sumbit')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
