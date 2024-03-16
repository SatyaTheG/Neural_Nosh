import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FoodRecommendScreen extends StatefulWidget {
  List l1;
  List l2;
  List l3;

  FoodRecommendScreen({
    super.key,
    required this.l1,
    required this.l2,
    required this.l3,
  });

  @override
  State<FoodRecommendScreen> createState() => _FoodRecommendScreenState();
}

class _FoodRecommendScreenState extends State<FoodRecommendScreen> {
  @override
  Widget build(BuildContext context) {
    var Mylen1 = widget.l1;
    var Mylen2 = widget.l2;
    var Mylen3 = widget.l3;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Hero(
              tag: 'Lottie',
              child: Lottie.asset('assets/animation/foodRecommend.json')),
          Text('Food Recommendation', style: TextStyle(fontSize: 30)),
          SizedBox(
            height: 20,
          ),
          Text(
            'BreakFast',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 30),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: Mylen1.length - 1,
            itemBuilder: (context, index) {
              var myList1 = Mylen1;
              return Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container( width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text(
                        '${myList1[index]}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ));
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Lunch',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 30),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: Mylen2.length - 1,
            itemBuilder: (context, index) {
              var myList2 = Mylen1;
              return Center(
                  child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '${myList2[index]}',
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
              ));
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Dinner',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 30),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: Mylen3.length - 1,
            itemBuilder: (context, index) {
              var myList3 = Mylen1;
              return Center(
                  child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Container( width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '${myList3[index]}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ));
            },
          )
        ]),
      ),
    ));
  }
}
