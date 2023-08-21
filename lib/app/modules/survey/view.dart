import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:survey_system/app/data/models/survey_model.dart';
import 'package:survey_system/app/data/services/survey_service.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  Future insertFormToDatabase(SurveyModel surveyModel) async {
    var url =
        Uri.parse("http://localhost/survey_system_api/src/post_survey.php");

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(surveyModel.toJson()));
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Task>(
        future: getSampleTask(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            final task = snapshot.data!;

            return SurveyKit(
              onResult: (SurveyResult result) {
                // print(result.finishReason);
                Navigator.pushNamed(context, '/');

                final jsonResult = result.toJson();
                final results = jsonResult['results'];

                SurveyModel surveyModel = SurveyModel(
                    outletName: results[1]['results'][0]['result']['value'],
                    status: jsonResult['finishReason'],
                    startDate: DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(jsonResult['startDate'])),
                    endDate: DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(jsonResult['endDate'])),
                    customerName: results[2]['results'][0]['result'],
                    customerAge: results[3]['results'][0]['result'],
                    customerLocation: results[4]['results'][0]['result'],
                    surveyDate: DateFormat('yyyy-MM-dd').format(
                        DateTime.parse(results[5]['results'][0]['result'])),
                    productPreferences: results[6]['results'][0]['result']
                    ['value'],
                    buyingBehaviors: results[7]['results'][0]['result']
                    ['value']);
                insertFormToDatabase(surveyModel);
              },
              task: task,
              showProgress: true,
              surveyProgressbarConfiguration: SurveyProgressConfiguration(
                backgroundColor: Colors.white,
              ),
            );
          }
          return CircularProgressIndicator.adaptive();
        },
      ),
    );
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Welcome to the\nPOSable\nSupermarket Survey',
          text: 'Contribute to improve our products and  services!',
          buttonText: 'Let\'s go!',
        ),

        QuestionStep(
          title: 'Supermarket Outlets',
          text: 'Which supermarket outlets are you right now?',
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Victoria Secret', value: 'Victoria Secret'),
              TextChoice(text: 'Bvlgari', value: 'Bvlgari'),
            ],
          ),
        ),

        /// NAME
        QuestionStep(
          title: 'What is your name?',
          answerFormat: TextAnswerFormat(
            hint: 'Please enter your name',
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),

        /// AGE
        QuestionStep(
          title: 'How old are you?',
          answerFormat: IntegerAnswerFormat(
            hint: 'Please enter your age',
          ),
        ),

        /// LOCATION
        QuestionStep(
          title: 'Where is your location?',
          answerFormat: TextAnswerFormat(
            hint: 'Please enter your location',
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),

        /// DATE OF SURVEY
        QuestionStep(
          title: 'When you take the survey?',
          answerFormat: DateAnswerFormat(
            minDate: DateTime.utc(1970),
            defaultDate: DateTime.now(),
            maxDate: DateTime.now(),
          ),
        ),

        /// PRODUCT
        QuestionStep(
          title: 'Product Preferences and Perceptions',
          text: 'What is your favorite brand of product?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'A. Apple', value: 'Apple'),
              TextChoice(text: 'B. Samsung', value: 'Samsung'),
            ],
          ),
        ),

        /// BUYING BEHAVIOURS
        QuestionStep(
          title: 'Buying Behaviors',
          text: 'Where do you usually buy products?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'A. Online', value: 'Online'),
              TextChoice(
                  text: 'B. Department Stores', value: 'Department Stores'),
            ],
          ),
        ),

        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey!',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    return Future.value(task);
  }
}
