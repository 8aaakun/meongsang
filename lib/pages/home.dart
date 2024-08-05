import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meongsang/pages/meditation.dart';
import 'package:meongsang/pages/recomend.dart';
import 'aiConsult.dart';
import 'meongsangRecordsPage.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Image(
          image: AssetImage('assets/images/logo.png'),
        )),
      ),

      body: Container(
        child: Center(
          child: ListView(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Text(
                "반가워요!",
                style: TextStyle(
                    fontFamily: 'GmarketSansTTF',
                    fontWeight: FontWeight.normal,
                    fontSize: 50),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "어떤 명상을 하고 싶으세요?",
                style: TextStyle(
                    fontFamily: 'GmarketSansTTF',
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),

            GestureDetector(
                onTap: () {Get.to(AiConsult(), transition: Transition.fadeIn);},
                child: Menu(text: "AI 상담")
            ),

            GestureDetector(
              onTap: (){Get.to(Recomend());},
                child: Menu(text: "명상 주제 추천받기")
            ),

            GestureDetector(
                onTap: (){Get.to(Meditation(meditateTime: 10, subject: "1",));},
                child: Menu(text: "머리 비우기"
                )
            ),

            GestureDetector(
              onTap: () { Get.to(MeongsangRecordsPage(), transition: Transition.fadeIn); },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100.0, vertical: 40),
                child: Container(
                    child: Center(
                        child: Text(
                      "명상 기록 보기",
                      style:
                          TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                    )),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(color: Colors.black, width: 5),
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
          ]),
        ),
      ),
    );
    ;
  }
}

class Menu extends StatelessWidget {
  final String text;

  Menu({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Container(
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
          )),
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.black, width: 5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 4.0,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ])),
    );
  }
}
