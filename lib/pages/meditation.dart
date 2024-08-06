import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meongsang/Meditations/meditations.dart';
import 'package:meongsang/pages/addMemo.dart';
import 'package:meongsang/pages/home.dart';
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
  final Meditations _meditations = Meditations();
  List<String> _currentMeditation = [];
  final FlutterTts _tts = FlutterTts();
  final _player = AudioPlayer();
  String _mediText = "";
  bool _goAddMemoBtn = false;

  int _curIdx = 0;

  Future _startSpeaking() async {
    _curIdx = 0;
    await _speakCurrentIndex();
  }

  Future _speakCurrentIndex() async {
    if (_curIdx < _currentMeditation.length) {
      await _tts.speak(_currentMeditation[_curIdx]);
      setState(() {
        _mediText = _currentMeditation[_curIdx];
      });
    }
  }

  void _onSpeakComplete() {
    _curIdx++;
    if (_curIdx == _currentMeditation.length) {
      setState(() {
        _mediText = "";
      });
    }
    if (_curIdx < _currentMeditation.length) {
      _speakCurrentIndex();
    }
  }

  void _setAudio() {
    _player.setLoopMode(LoopMode.one);
    if (widget.subject == "1")
      _player.setAsset("assets/bgm/Drifting at 432 Hz - Unicorn Heads.mp3");
    else if (widget.subject == "2")
      _player.setAsset("assets/bgm/The Inner Sound - Jesse Gallagher.mp3");
    else if (widget.subject == "3")
      _player.setAsset("assets/bgm/Venkatesananda - Jesse Gallagher.mp3");
    else
      _player.setAsset("assets/bgm/Spirit of Fire - Jesse Gallagher.mp3");
  }

  void _playAudio() {
    _player.play();
  }

  @override
  void initState() {
    super.initState();
    _currentMeditation = _meditations.getMeditation(widget.subject);
    _tts.setLanguage("ko-KR");
    _tts.setSpeechRate(1);
    _tts.setCompletionHandler(() {
      _onSpeakComplete();
    });
    _setAudio();
  }

  @override
  void dispose() {
    _tts.stop();
    _player.dispose();
    super.dispose();
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
            Get.offAll(Home(), transition: Transition.fadeIn);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
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
              onStart: () async {
                _playAudio();
                await _startSpeaking();
              },
              onComplete: () {
                _tts.speak("명상이 종료되었습니다. 명상 기록을 남기러 가시겠습니까?");
                _player.dispose();
                setState(() {
                  _goAddMemoBtn=true;
                });
              },
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              duration: 60,
              //widget.meditateTime*60,
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
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Stack(
                        children: [
                  Text(
                    _mediText,
                    style:
                        TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                  ),
                          Visibility(
                            visible: _goAddMemoBtn,
                            child: Center(
                              child: ElevatedButton(
                                  onPressed: (){
                                    Get.to(AddMemo(subject: widget.subject,), transition: Transition.fadeIn);
                                  },
                                  child: Text("명상기록 남기기")
                              ),
                            ),
                          )
                ])),
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
