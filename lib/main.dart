import 'package:flutter/material.dart';
import 'package:meongsang/pages/home.dart';

void main() {
  runApp(const Meongsang());
}

class Meongsang extends StatelessWidget {
  const Meongsang({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Meongsang",
      home: Home(),

    );
  }
}

