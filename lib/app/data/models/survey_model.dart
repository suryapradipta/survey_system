class SurveyModel {
  final String status;
  final String startDate;
  final String endDate;
  final String outletName;
  final String surveyDate;
  final String customerName;
  final int customerAge;
  final String customerLocation;
  final String productPreferences;
  final String buyingBehaviors;

  SurveyModel(
      {required this.status,
      required this.startDate,
      required this.endDate,
      required this.outletName,
      required this.customerName,
      required this.customerAge,
      required this.customerLocation,
      required this.surveyDate,
      required this.productPreferences,
      required this.buyingBehaviors});

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
        status: json['status'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        outletName: json['outlet_name'],
        customerName: json['customer_name'],
        customerAge: json['customer_age'],
        customerLocation: json['customer_location'],
        productPreferences: json['product_answer'],
        buyingBehaviors: json['behavior_answer'],
        surveyDate: json['survey_date'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'start_date': startDate,
        'end_date': endDate,

        'outlet_name': outletName,

        'customer_name': customerName,
        'customer_age': customerAge,
        'customer_location': customerLocation,
        'survey_date': surveyDate,

        'product_answer': productPreferences,
        'behavior_answer': buyingBehaviors,
      };
}
