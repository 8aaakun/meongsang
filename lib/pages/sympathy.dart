import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Sympathy extends StatefulWidget {
  final List<String> content;
  final String? emotion;

  Sympathy({required this.content, required this.emotion});

  @override
  State<Sympathy> createState() => _SympathyState();
}

class _SympathyState extends State<Sympathy> {
  int _idx = 0;
  bool _ani = true;
  bool _btnAni = false;
  Map _emotionToSentence = {
    "1": "'분노'를 주제로 명상할까요?",
    "2": "'슬픔'를 주제로 명상할까요?",
    "3": "'행복'를 주제로 명상할까요?",
    "4": "명상할까요?"
  };

  @override
  void initState() {
    super.initState();
    widget.content.add(_emotionToSentence[widget.emotion]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          heightFactor: 200,
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeIn(
                  child: Text(widget.content[_idx],
                  style: TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 22)),
                  delay: Duration(milliseconds: 50),
                  duration: Duration(seconds: 2),
                  animate: _ani,
                  onFinish: (direction) {
                    setState(() {
                      if (_idx < widget.content.length - 1) {
                        _ani = !_ani;
                        if (_ani) {
                          _idx++;
                        }
                      }
                      if(_idx >= widget.content.length - 1){
                        _btnAni=true;
                      }
                    });
                  },
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FadeIn(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("네!"),
                    ),
                    animate: _btnAni,
                    duration: Duration(seconds: 2),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
