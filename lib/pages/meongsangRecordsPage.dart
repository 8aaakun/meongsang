import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meongsang/pages/recordDetailPage.dart';
import 'package:meongsang/services/saveRecord.dart';

class MeongsangRecordsPage extends StatefulWidget {
  const MeongsangRecordsPage({super.key});

  @override
  State<MeongsangRecordsPage> createState() => _MeongsangRecordsPageState();
}

class _MeongsangRecordsPageState extends State<MeongsangRecordsPage> {
  List<Map<String, dynamic>> _entries = [];

  @override
  void initState() {
    super.initState();
    _refreshEntries();
  }

  Future<void> _refreshEntries() async {
    final data = await SaveRecord.instance.queryAllEntries();
    print('Fetched entries: $data'); // 데이터베이스에서 가져온 데이터 확인
    setState(() {
      _entries = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("명상 기록 보기"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Text(
                "나의 명상기록",
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
          Expanded(
            child: ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final record = List.from(_entries.reversed)[index]; //최근이 위에 오게
                return ListTile(
                    title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffFFB6B6),
                        Color(0xffF4C0AA),
                        Color(0xffABFF56)
                      ],
                    ),
                  ),
                  child: ListTile(
                    title: Text(record['subject']),
                    subtitle: Text(record['date']),
                    onTap: () {
                      Get.to(RecordDetailPage(record: record));
                    },
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
