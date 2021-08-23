import 'package:flutter/material.dart';
import 'package:flutter_mealset/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide Debug Banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Meal Set',
      theme: ThemeData(
        fontFamily: 'Prompt',
      ),
      // เรียกใช้ HomeScreen() เป็นหน้า home
      home: HomeScreen(),
    );
  }
}
