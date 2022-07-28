import 'package:flutter/material.dart';
import 'package:gender_prediction/injection.dart';
import 'package:gender_prediction/presentation/view/ui/home_page.dart';

void main() {
  initInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gender Prediction',
      theme: ThemeData(
          primarySwatch: Colors.orange, primaryColor: Colors.orangeAccent),
      home: const HomePage(),
    );
  }
}
