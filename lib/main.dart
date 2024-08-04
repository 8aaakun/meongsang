import 'package:flutter/material.dart';
import 'package:meongsang/pages/home.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(const Meongsang());
}

class Meongsang extends StatelessWidget {
  const Meongsang({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Meongsang",
      home: Home(),

    );
  }
}

