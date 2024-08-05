import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

import 'meditation.dart';

class SettingsScreen extends StatefulWidget {
  //SettingsScreen({Key? key}) : super(key: key);
  final String subject;
  SettingsScreen({required this.subject});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int meditateTime = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            )),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "명상 할 준비 되셨나요?",
                  style: TextStyle(
                      fontFamily: 'GmarketSansTTF',
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 60),
                child: Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "명상 타이머 설정",
                              style: TextStyle(
                                fontFamily: 'GmarketSansTTF',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NumberPicker(
                            value: meditateTime,
                            minValue: 5,
                            maxValue: 120,
                            step: 5,
                            itemHeight: 100,
                            axis: Axis.horizontal,
                            onChanged: (value) =>
                                setState(() => meditateTime = value),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black26),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => setState(() {
                                    final newValue = meditateTime - 5;
                                    meditateTime = newValue.clamp(0, 120);
                                  }),
                                ),
                                Text('명상 시간: $meditateTime분',
                                  style:
                                  TextStyle(fontFamily: 'GmarketSansTTF')),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => setState(() {
                                    final newValue = meditateTime + 5;
                                    meditateTime = newValue.clamp(0, 120);
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // height: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
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
              GestureDetector(
                onTap: () {
                  Get.to(Meditation(meditateTime:meditateTime, subject: widget.subject,));
                  },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 140.0),
                  child: Container(
                      child: Center(
                          child: Text(
                            "명상 시작",
                            style:
                            TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                          )),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
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
            ],
          ),
        ),
      ),
    );
  }

  buildDivider() {
    return Text(
      ':',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 30.0,
      ),
    );
  }

  Widget _buildHourPicker() {
    return Container(
      width: 50.0,
      height: 200.0,
      child: ListWheelScrollView(
        onSelectedItemChanged: (val) {},
        controller: FixedExtentScrollController(initialItem: 00),
        itemExtent: 40.0,
        // useMagnifier: true,
        children: List<Widget>.generate(
          12,
              (int index) {
            final int displayHour = index;

            return _TimeText(text: displayHour.toString());
          },
        ),
      ),
    );
  }

  buildMinutePicker() {
    return Container(
      width: 50.0,
      height: 200.0,
      child: ListWheelScrollView(
        onSelectedItemChanged: (val) {},
        controller: FixedExtentScrollController(initialItem: 00),
        itemExtent: 40.0,
        // useMagnifier: true,
        children: List<Widget>.generate(
          60,
              (int index) {
            return _TimeText(text: index.toString());
          },
        ),
      ),
    );
  }

  buildSecondsPicker() {
    return Container(
      width: 50.0,
      height: 200.0,
      child: ListWheelScrollView(
        onSelectedItemChanged: (val) {},
        controller: FixedExtentScrollController(initialItem: 0),
        itemExtent: 40.0,
        // useMagnifier: true,
        children: List<Widget>.generate(
          60,
              (int index) {
            return _TimeText(text: index.toString());
          },
        ),
      ),
    );
  }
}

class _TimeText extends StatelessWidget {
  final String text;

  _TimeText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.padLeft(2, '0'),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      ),
    );
  }
}
