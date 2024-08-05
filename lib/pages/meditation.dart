import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';

import '../customWidgets/wave.dart';

class Meditation extends StatefulWidget {
  //const Meditation({super.key});
  final int meditateTime;
  final String subject;
  Meditation({required this.meditateTime, required this.subject});

  @override
  State<Meditation> createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Image(
          image: AssetImage('assets/images/logo.png'),
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Text(
                "명상을 진행 중입니다.",
                style: TextStyle(
                    fontFamily: 'GmarketSansTTF',
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              )),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),

          // 카운트 다운 타이머
          Center(
            heightFactor: 0.8,
            child: CircularCountDownTimer(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              duration: widget.meditateTime*60,
              fillColor: Colors.black,
              ringColor: const Color(0xffD9D9D9),
              isReverseAnimation: true,
              isReverse: true,
              strokeWidth: 30,
              strokeCap: StrokeCap.round,
              fillGradient: const LinearGradient(
                colors: [
                  Color(0xffFFB6B6),
                  Color(0xffF4C0AA),
                  Color(0xffABFF56)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              textFormat: CountdownTextFormat.MM_SS,
            ),
          ),

          Center(
              heightFactor: 0.5,
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 6,
                  child: Wave())),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Container(
                child: Center(
                    child: Text(
                  "준비가 되었다면 눈을 감습니다.",
                  style: TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                )),
                height: MediaQuery.of(context).size.height / 4.5,
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
          )
        ],
      ),
    );
  }
}
