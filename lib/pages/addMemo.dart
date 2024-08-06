import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../services/saveRecord.dart';
import 'home.dart';

class AddMemo extends StatefulWidget {
  final String subject;
  AddMemo({required this.subject});
  @override
  _AddMemoState createState() => _AddMemoState();
}

class _AddMemoState extends State<AddMemo> {
  final TextEditingController _controller = TextEditingController();
  final Map subToString = {
    "1" : "분노",
    "2" : "슬픔",
    "3" : "행복",
    "4" : "명상",
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
        body: Stack(
          children: [
            // 배경에 그라데이션 원 추가
            Positioned(
              bottom: -250,
              right: -100,
              child: Container(
                width: 700,
                height: 700,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFFB6B6),
                      Color(0xffF4C0AA),
                      Color(0xffABFF56),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "명상이 종료되었습니다",
                      style: TextStyle(
                        fontFamily: 'GmarketSansTTF',
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "오늘의 명상은 어땠나요?\n감상을 남겨주세요!",
                      style: TextStyle(
                        fontFamily: 'GmarketSansTTF',
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      height: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(color: Colors.black, width: 4),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 4.0,
                            offset: Offset(0, 7),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _controller,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: '오늘은...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 10),
                    child: GestureDetector(
                      onTap: _showConfirmationDialog,
                      child: Container(
                        child: Center(
                          child: Text(
                            "감상 남기기",
                            style: TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                          ),
                        ),
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
                              offset: Offset(0, 7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 0),
                    child: GestureDetector(
                      onTap: () {
                        _saveEntry("");
                        Get.offAll(Home(), transition: Transition.fadeIn);
                        },
                      child: Container(
                        child: Center(
                          child: Text(
                            "건너뛰기",
                            style: TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
                          ),
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: Colors.black, width: 4),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 4.0,
                              offset: Offset(0, 7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // 다이얼로그 외부 터치로 닫을 수 없게 함
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('저장하시겠습니까?',
            style: TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소', style: TextStyle(fontFamily: 'GmarketSansTTF')),
              onPressed: () {
                Navigator.of(context).pop(); // 첫 번째 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text('저장', style: TextStyle(fontFamily: 'GmarketSansTTF')),
              onPressed: () {
                Navigator.of(context).pop(); // 첫 번째 다이얼로그 닫기
                _saveEntry(_controller.text);
                _showSuccessDialog(); // 두 번째 다이얼로그 열기
              },
            ),
          ],
        );
      },
    );
  }

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now);
    return strToday;
  }
  Future<void> _saveEntry(String? review) async {
    Map<String, dynamic> row = {
      'date': getToday(),
      'subject': subToString[widget.subject],
      'review': review,
    };
    await SaveRecord.instance.insertEntry(row);
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('저장되었습니다!', style: TextStyle(fontFamily: 'GmarketSansTTF', fontSize: 17)),
          actions: <Widget>[
            TextButton(
              child: Text('홈화면으로 이동', style: TextStyle(fontFamily: 'GmarketSansTTF')),
              onPressed: () {
                Navigator.of(context).pop(); // 두 번째 다이얼로그 닫기
                Get.offAll(Home(), transition: Transition.fadeIn); // 홈화면으로 이동
              },
            ),
          ],
        );
      },
    );
  }
}
