import 'package:flutter/material.dart';
import 'package:ridehailing/pages/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'rideHailingDriver',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ), 
      home: LoginForm()
      // debugShowCheckedModeBanner: ,
    );
  }
}