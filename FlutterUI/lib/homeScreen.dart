import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'bmiScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? gender; // Change type to int
  String? dietValue;
  String? activityValue;
  int? ageValue;


  List<String> listActivity = [
    'Little/no exercise',
    'Light exercise',
    'Moderate exercise (3-5 days/wk)',
    'Very active (6-7 days/wk)',
    'Extra active (very active & physical job)'
  ];

  List<String> listDiet = [
    "Maintain weight",
    "Mild weight loss",
    "Weight loss",
    "Extreme weight loss"
  ];
  List<String> listGender = [
    "Male",
    "Female",
  ];

  List<int> listAge = [
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    97,
    98,
    99,
    100
  ];

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

// double calculate_BMI({required var height, required var weight}) {
  //   var resultBMI = weight / ((height / 100) * (height / 100));
  //   return double.parse(resultBMI.toStringAsFixed(2));
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9bcbe1),
      appBar: AppBar(
                backgroundColor: const Color(0xff9bcbe1),
        elevation: 0.0,
        title: const Text('My Fitness'),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: Container(
          color: const Color(0xff9bcbe1),
          child: Center(
              child: Lottie.asset(
            'assets/animation/doctor_animation.json',
          )),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Container(
              decoration: const BoxDecoration(color: Color(0xffffffff)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  FadeAnimatedText(
                                    'Fuel Your Body Right',
                                    textStyle: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  FadeAnimatedText(
                                    'Start with Your Personalized BMI Calculation.',
                                    textStyle: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                repeatForever: true,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  FadeAnimatedText(
                                    'Fuel Your Body Right',
                                    textStyle: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  FadeAnimatedText(
                                    'Start with Your Personalized BMI Calculation.',
                                    textStyle: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange),
                                  ),
                                ],
                                repeatForever: true,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (0.80 / 2),
                        child: TextField(
                          controller: heightController,
                          decoration: InputDecoration(
                              label: const Text('Height (cms)'),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black))),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (0.80 / 2),
                        child: TextField(
                          controller: weightController,
                          decoration: InputDecoration(
                              label: const Text('Weight (kgs)'),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.black))),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * (0.80 / 5),
                            child: DropdownButton(
                              isExpanded: true,
                              value: ageValue,
                              borderRadius: BorderRadius.circular(10),
                              hint: Text('Select Age'),
                              dropdownColor: Colors.yellow.shade50,
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                              ),
                              items: listAge
                                  .map((selectedValue) => DropdownMenuItem(
                                      value: selectedValue,
                                      child: Text(selectedValue.toString())))
                                  .toList(),
                              onChanged: (value) {
                                ageValue = value!;
                                setState(() {});
                              },
                            )),
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * (0.80 / 5),
                            child: DropdownButton(
                              isExpanded: true,
                              value: gender,
                              borderRadius: BorderRadius.circular(10),
                              hint: Text('Select Gender'),
                              dropdownColor: Colors.yellow.shade50,
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                              ),
                              items: listGender
                                  .map((selectedValue) => DropdownMenuItem(
                                      value: selectedValue,
                                      child: Text(selectedValue.toString())))
                                  .toList(),
                              onChanged: (value) {
                                gender = value;
                                setState(() {});
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (0.80 / 2),
                        child: DropdownButton(
                          isExpanded: true,
                          value: dietValue,
                          borderRadius: BorderRadius.circular(10),
                          hint: Text('Select Diet'),
                          dropdownColor: Colors.yellow.shade50,
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                          ),
                          items: listDiet
                              .map((selectedValue) => DropdownMenuItem(
                                  value: selectedValue,
                                  child: Text(selectedValue.toString())))
                              .toList(),
                          onChanged: (value) {
                            dietValue = value!;

                            setState(() {});
                          },
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * (0.80 / 2),
                        child: DropdownButton(
                          isExpanded: true,
                          value: activityValue,
                          borderRadius: BorderRadius.circular(10),
                          hint: Text('Select Activity'),
                          dropdownColor: Colors.yellow.shade50,
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                          ),
                          items: listActivity
                              .map((selectedValue) => DropdownMenuItem(
                                  value: selectedValue,
                                  child: Text(selectedValue.toString())))
                              .toList(),
                          onChanged: (value) {
                            activityValue = value!;

                            setState(() {});
                          },
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        double heightVar =
                            double.parse(heightController.text.toString());
                        double weightVar =
                            double.parse(weightController.text.toString());
                        double dietVar = dietValue == "Maintain weight"
                            ? 1.0
                            : dietValue == "Mild weight loss"
                                ? 0.9
                                : dietValue == "Weight loss"
                                    ? 0.8
                                    : 0.6;
                        double ageVar = double.parse(ageValue.toString());
                        String genderValue = gender.toString();
                        String activityVal = activityValue.toString();

                        print('Age:' + ageValue.toString());
                        print('Gender:' + genderValue.toString());
                        print('Height:' + heightVar.toString());
                        print('Weight:' + weightVar.toString());
                        print('DietNumber:' + dietVar.toString());
                        print('Diet:' + dietValue.toString());
                        print('Activity:' + activityVal.toString());

                        // var resultBMI = calculate_BMI(
                        //     height: int.parse(heightController.text.toString()),
                        //     weight:
                        //         int.parse(weightController.text.toString()));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BMIScreen(
                                  height: heightVar,
                                  weight: weightVar,
                                  age: ageVar,
                                  diet: dietVar,
                                  gender: genderValue,
                                  activity: activityVal),
                            ));
                        heightController.clear();
                        weightController.clear();
                        setState(() {
                          ageValue = null;
                          dietValue = null;
                          gender = null;
                        });
                      },
                      child: const Text('Calculate'),
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.blue, width: 1.5)),
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      ]),
    );
  }
}
