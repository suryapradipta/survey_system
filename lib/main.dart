import 'package:flutter/material.dart';
import 'package:survey_system/app/modules/chart/pie_chart_sample2.dart';
import 'package:survey_system/app/modules/login/login.dart';
import 'package:survey_system/app/modules/survey/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

