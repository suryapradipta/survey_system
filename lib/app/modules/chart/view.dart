import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey_system/app/data/models/survey_model.dart';
import 'package:http/http.dart' as http;

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<SurveyModel> fromJson(String strJson) {
    final data = jsonDecode(strJson);
    return List<SurveyModel>.from(data.map((i)=> SurveyModel.fromJson(i))).toList();
  }

  List<SurveyModel> surveys = [];

  Future<List<SurveyModel>> getSurvey() async {
    List<SurveyModel> listSurvey = [];
    final response = await http
        .get(Uri.parse("http://localhost/survey_system_api/src/get.php"));
    if(response.statusCode == 200) {
      listSurvey = fromJson(response.body);
    }
    return listSurvey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
