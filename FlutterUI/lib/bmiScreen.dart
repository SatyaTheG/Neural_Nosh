import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_fitness/consultNutritionScreen.dart';
import 'package:my_fitness/eatModel.dart';
import 'package:http/http.dart' as httpclient;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_fitness/foodRecommendScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class BMIScreen extends StatefulWidget {
  final height;
  final weight;
  final age;
  final diet;
  final gender;
  final activity;

  BMIScreen(
      {super.key,
      this.height,
      this.weight,
      this.age,
      this.diet,
      this.gender,
      this.activity});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  late Future<EatModel> getFood;

  // --web-browser-flag "--disable-web-security"
  @override
  void initState() {
    super.initState();
    getFood = getData(
        h: widget.height,
        w: widget.weight,
        a: widget.age,
        d: widget.diet,
        g: widget.gender,
        active: widget.activity);
  }

  Future<EatModel> getData(
      {var h, var w, var a, var d, var g, var active}) async {
    var myUrl = 'http://127.0.0.1:5000/calculate_recommendations';
    var requestBody = jsonEncode({
      // Add any data you need to send to the API

      "person_info": {
        "age": a,
        "height": h,
        "weight": w,
        "gender": g,
        "activity": active,
        "meals_calories_perc": {
          "breakfast": 0.35,
          "lunch": 0.40,
          "dinner": 0.25
        },
        "weight_loss": d
      }
    });
    try {
      var res = await httpclient.post(Uri.parse(myUrl),
          headers: {'Content-Type': 'application/json'}, body: requestBody);

      if (res.statusCode == 200) {
        return EatModel.fromJson(jsonDecode(res.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<EatModel>(
          future: getFood,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Container(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              }
              if (snapshot.hasData) {
                String bmi = snapshot.data!.bmiResult;
                List bmiList = bmi.split(' ');
                double bmiAns = double.parse(bmiList[4].toString());
                // print(bmiAns);
                // print(bmiAns + bmiAns);
                // print(bmi);
                // print(bmiList);

                var caloriesString = snapshot.data!.caloriesResult;
                List caloriesList = caloriesString.split(' ');
                // print(caloriesList);

                var foodString = snapshot.data!.recommendations;

                List<List<String>> extractAllSublists(String nestedListString) {
                  // Remove outermost square brackets and split the string by '], [' to get individual sublists
                  List<String> nestedListParts = nestedListString
                      .substring(1, nestedListString.length - 1)
                      .split('], ');

                  // Initialize a list to store all sublists
                  List<List<String>> allSublists = [];

                  // Iterate over each sublist string, parse it, and add it to the list of sublists
                  nestedListParts.forEach((sublistString) {
                    // If it's not the last sublist, remove the trailing square bracket
                    if (!sublistString.endsWith(']')) {
                      sublistString += ']';
                    }

                    // Parse the sublist string to get the list of strings
                    List<String> sublist = sublistString
                        .substring(1, sublistString.length - 1)
                        .split(', ');

                    // Remove any leading or trailing single quotes from each string
                    sublist = sublist
                        .map((str) => str.replaceAll(RegExp("^'|'\$"), ''))
                        .toList();

                    // Add the sublist to the list of sublists
                    allSublists.add(sublist);
                  });

                  return allSublists;
                }

                List l1 = extractAllSublists(foodString)[0];
                List l2 = extractAllSublists(foodString)[1];
                List l3 = extractAllSublists(foodString)[2];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Maintain Weight',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${caloriesList[0]}' + ' Calories/day',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '-0 kg/week',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                )
                              ],
                            ).animate().fadeIn(
                                duration: Duration(milliseconds: 600),
                                delay: Duration(seconds: 1)),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Mild Weight Loss',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${caloriesList[1]}' + ' Calories/day',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '-0.25 kg/week',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                )
                              ],
                            ).animate().fadeIn(
                                duration: Duration(milliseconds: 600),
                                delay: Duration(seconds: 2)),
                            SizedBox(height: 20),
                            Column(
                              children: [
                                Text(
                                  'Weight Loss',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${caloriesList[2]}' + ' Calories/day',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '-0.5 kg/week',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                )
                              ],
                            ).animate().fadeIn(
                                duration: Duration(milliseconds: 600),
                                delay: Duration(seconds: 3)),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Extreme Weight Loss',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${caloriesList[3]}' + ' Calories/day',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '-1 kg/week',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                )
                              ],
                            ).animate().fadeIn(
                                duration: Duration(milliseconds: 600),
                                delay: Duration(seconds: 4)),
                          ],
                        ),
                        Center(
                          child: Container(
                            child: Column(children: [
                              Container(
                                height: MediaQuery.of(context).size.width * 0.2,
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                    color: (bmiAns >= 18.5 && bmiAns < 25)
                                        ? Colors.green.shade600
                                        : bmiAns < 18.5
                                            ? Colors.redAccent
                                            : (bmiAns >= 25 && bmiAns < 30)
                                                ? Colors.orange
                                                : Colors.red),
                                child: Center(
                                  child: Text(
                                    '${bmiList[4]}',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                                  .animate()
                                  .scale(
                                      curve: Curves.easeInOutSine,
                                      duration: Duration(seconds: 2))
                                  .then()
                                  .rotate(
                                    duration: Duration(seconds: 3),
                                    curve: Curves.ease,
                                  ),
                              Text(
                                'kg/m²',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ).animate().scaleX(
                                  curve: Curves.bounceInOut,
                                  duration: Duration(milliseconds: 5000)),
                              SizedBox(
                                height: 50,
                              ),
                              AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  WavyAnimatedText(
                                    (bmiAns >= 18.5 && bmiAns < 25)
                                        ? 'Normal'
                                        : bmiAns < 18.5
                                            ? 'Under Weight'
                                            : (bmiAns >= 25 && bmiAns < 30)
                                                ? 'Over Weight'
                                                : 'Obesity',
                                    speed: Duration(milliseconds: 400),
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ).animate().scale(
                                  duration: Duration(milliseconds: 400),
                                  delay: Duration(seconds: 4)),
                              Text(
                                'Healthy BMI range: 18.5 kg/m² - 25 kg/m²',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ).animate().scaleX(
                                  curve: Curves.bounceInOut,
                                  duration: Duration(milliseconds: 5000)),
                              SizedBox(
                                height: 50,
                              )
                            ]),
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () async {
                                  var uri = Uri.parse("http://127.0.0.1:7860");
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    // can't launch url
                                  }
                                },
                                child: Lottie.asset(
                                    'assets/animation/botman.json',
                                    height: 200,
                                    width: 200))
                          ],
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConsultNutrition(),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  children: [
                                    Lottie.asset(
                                        'assets/animation/nutritionist.json',
                                        height: 100,
                                        width: 200),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      color: Colors.green,
                                      child: const Center(
                                          child: Text('Nutritionists',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FoodRecommendScreen(l1: l1, l2: l2, l3: l3),
                              )),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Hero(
                                      tag: 'Lottie',
                                      child: Lottie.asset(
                                          'assets/animation/foodRecommend.json',
                                          height: 100,
                                          width: 200),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: const Center(
                                            child: Text('Recommended Food',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        color: Colors.amber.withOpacity(0.8)),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )
                    // Text('${snapshot.data!.caloriesResult}',
                    //     style: TextStyle(
                    //         fontSize: 18, fontWeight: FontWeight.w200)),
                    // Text('${snapshot.data!.recommendations}',
                    //     style: TextStyle(
                    //         fontSize: 20, fontWeight: FontWeight.w600))
                  ],
                );
              } else {
                return Center(
                  child: Container(
                    child: Text(getFood.toString()),
                  ),
                );
              }
            } else {
              return Center(
                child: Container(
                  child: Text('No data received'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
