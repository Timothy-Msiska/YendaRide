import 'package:flutter/material.dart';
import 'package:uber/views/register.dart';
import 'package:uber/views/ride_summary.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YENDA RIDE Login',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: PhoneLoginPage(),
    );
  }
}
