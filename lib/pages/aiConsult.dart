import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meongsang/pages/sympathy.dart';
import 'package:meongsang/services/openAiService.dart';

class AiConsult extends StatefulWidget {
  const AiConsult({super.key});

  @override
  State<AiConsult> createState() => _AiConsultState();
}

class _AiConsultState extends State<AiConsult> {
  TextEditingController _con = TextEditingController();
  bool _btnVisible = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
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
          body: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "오늘은 어떤 일이 있었나요?\n그리고 무슨 기분이었나요?\n무엇이든 이야기해주세요.",
                    style: TextStyle(
                      fontFamily: 'GmarketSansTTF',
                      fontSize: 20
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _con,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    onChanged: (text){
                      setState(() {
                        if(text.isEmpty){
                          _btnVisible = false;
                        }
                        else{
                          _btnVisible = true;
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _btnVisible,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        OpenAIService model = OpenAIService();
                        String response = await model.createModel(_con.text);
                        List<String> content = response.split('/');
                        String emotion = content.last;
                        content.removeLast();
                        ///1:분노, /2:슬픔, /3:행복, /4:판단불가"
                        Get.to(Sympathy(content: content, emotion: emotion), transition: Transition.fadeIn);
                      },
                      child: Text("확인", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFB6B6),
                        overlayColor: Color(0xffABFF56)
                      ),
      
                    ),
                  ),
                ),
            ],
          )
      ),
    );
  }
}

