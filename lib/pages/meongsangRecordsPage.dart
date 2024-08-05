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
      body: ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          final record = _entries[index];
          return ListTile(
            title: Text(record['subject']),
            subtitle: Text(record['date']),
            onTap: () {
              Get.to(RecordDetailPage(record: record));
            },
          );
        },
      ),
    );
  }
}
