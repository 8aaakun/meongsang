import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meongsang/pages/meditation.dart';
import 'package:meongsang/pages/settingScreen.dart';

class Recomend extends StatefulWidget {
  const Recomend({super.key});

  @override
  State<Recomend> createState() => _RecomendState();
}

class _RecomendState extends State<Recomend> {
  final List<String> _subjects = [
    "분노",
    "슬픔",
    "행복"
  ];
  final List<String> _means = [
    "[명사] 분개하여 몹시 성을 냄",
    "[명사] 슬픈 마음이나 느낌.",
    "[명사] 복된 좋은 운수."
  ];
  late int _subjectNum;

  void _randomSubject(){
    final _random = Random();
    setState(() {
      _subjectNum = _random.nextInt(3).toInt();
    });

  }

  @override
  void initState(){
    super.initState();
    _randomSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Padding(
                  padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
                  child: Text(
                    "이런 주제는 어떠세요?",
                    style: TextStyle(
                        fontFamily: 'GmarketSansTTF',
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Container(
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _subjects[_subjectNum],
                              style:
                              TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              _means[_subjectNum],
                              style:
                              TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 15, color: Colors.white),
                            ),
                          ],
                        )
                    ),
                    height: MediaQuery.of(context).size.height/5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffFFB6B6),
                            Color(0xffF4C0AA),
                            Color(0xffABFF56)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 4.0,
                            offset: Offset(0, 7), // changes position of shadow
                          ),
                        ])),
              ),
              Center(
                heightFactor: 3,
                child: Text(
                  "이 주제로 명상해 볼까요?",
                  style:
                  TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height/5,
              ),

              GestureDetector(
                onTap: (){Get.to(SettingsScreen(subject: (_subjectNum+1).toString(),), transition: Transition.fadeIn);},
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
                  child: Container(
                      child: Center(
                          child: Text(
                            "이 주제로 명상하기",
                            style:
                            TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                          )),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black, width: 4),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffFFB6B6),
                              Color(0xffF4C0AA),
                              Color(0xffABFF56)
                            ],
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 4.0,
                              offset: Offset(0, 7), // changes position of shadow
                            ),
                          ])),
                ),
              ),

              GestureDetector(
                onTap: (){_randomSubject();},
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
                  child: Container(
                      child: Center(
                          child: Text(
                            "주제 다시 추천받기",
                            style:
                            TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                          )),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black, width: 4),

                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 4.0,
                              offset: Offset(0, 7), // changes position of shadow
                            ),
                          ])),
                ),
              ),

            ]
        )
    );
  }
}
