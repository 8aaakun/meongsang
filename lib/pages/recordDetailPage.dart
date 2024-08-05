import 'package:flutter/material.dart';

class RecordDetailPage extends StatelessWidget {
  final Map<String, dynamic> record;

  RecordDetailPage({required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("명상 기록 상세보기"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("주제: ${record['subject']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("날짜: ${record['date']}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(record['review'],
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
