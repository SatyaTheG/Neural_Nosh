import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultNutrition extends StatefulWidget {
  const ConsultNutrition({Key? key});

  @override
  State<ConsultNutrition> createState() => ConsultNutritionState();
}

class ConsultNutritionState extends State<ConsultNutrition> {
  // Define the dictionary containing states and their nutritionists
  Map<String, List<List<String>>> nutritionists = {
    'Bengal': [
      ['Dr. Hera', '+916225490345'],
      ['Dr. Souvik Chakraborty', '+919347634902'],
      ['Dr. Alan Baptist', '+919345782926'],
      ['Dr. Diksha Banthia', '+919743430000']
    ],
    'Maharashtra': [
      ['Dr. Heti Thakkar Shah', '+918850628080'],
      ['Ms. Archana Rairikar', '+919975434568'],
      ['Ms. Nikita Lawande', '+91 77100 38464']
    ],
    'Gujarat': [
      ['Dr. Krishna', '+918850628080'],
      ['Dr. Dietitian Navnidhi Vyas', '09712195930'],
      ['Dr. Dhara Bhatt', '+265 239 6015']
    ],
    'Madhya Pradesh': [
      ['Dr. Vivek Malviya', '9617733474'],
      ['Dr. Monika Kawadia', '8754044202'],
      ['Dr. Dhara Bhatt', '+265 239 6015']
    ],
    // Add more states and their nutritionists here
  };

  // Define a list of states
  List<String> states = [
    'Bengal',
    'Maharashtra',
    'Gujarat',
    'Madhya Pradesh',
    // Add more states here if needed
  ];

  void launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url,forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: states.length,
          itemBuilder: (context, index) {
            String state = states[index];
            List<List<String>> doctors = nutritionists[state]!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    String name = doctors[index][0];
                    String number = doctors[index][1];
                    return InkWell(onTap: () => launchPhoneCall(number),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(name),
                        subtitle: Text(number),
                      ),
                    );
                  },
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}