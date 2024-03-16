class EatModel {
  late String bmiResult;
  late String caloriesResult;
  late String recommendations;

  EatModel({required this.bmiResult, required this.caloriesResult, required this.recommendations});

  EatModel.fromJson(Map<String, dynamic> json) {
    bmiResult = json['bmi_result'];
    caloriesResult = json['calories_result'];
    recommendations = json['recommendations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bmi_result'] = this.bmiResult;
    data['calories_result'] = this.caloriesResult;
    data['recommendations'] = this.recommendations;
    return data;
  }
}
