import 'package:flutter/material.dart';
import 'package:meongsang/services/saveRecord.dart';

/*
    감상글 저장 기능 테스트 용 화면
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _subjectController = TextEditingController();
  final _reviewController = TextEditingController();
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

  Future<void> _saveEntry() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> row = {
        'date': _dateController.text,
        'subject': _subjectController.text,
        'review': _reviewController.text,
      };
      await SaveRecord.instance.insertEntry(row);
      print('Inserted entry: $row'); // 삽입한 데이터 확인
      _dateController.clear();
      _subjectController.clear();
      _reviewController.clear();
      _refreshEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(labelText: 'Subject'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _reviewController,
                    decoration: InputDecoration(labelText: 'Review'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a review';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _saveEntry,
                    child: Text('Save Entry'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  print('Rendering entry: ${_entries[index]}'); // 렌더링되는 데이터 확인
                  return ListTile(
                    title: Text(_entries[index]['subject']),
                    subtitle: Text(
                        '${_entries[index]['date']}: ${_entries[index]['review']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
