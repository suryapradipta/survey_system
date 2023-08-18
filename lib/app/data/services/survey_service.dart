import 'package:survey_system/app/data/models/survey_model.dart';
import 'package:http/http.dart' as http;

class SurveyService {
  var ADD_URL =
  Uri.parse("http://localhost/survey_system_api/src/post.php");
  Future<String> addSurvey(SurveyModel surveyModel) async {
    final response = await http.post(ADD_URL, body: surveyModel.toJson());
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return "Error";
    }
  }
}
