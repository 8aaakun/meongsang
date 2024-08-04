import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';

class Wave extends StatelessWidget {
  const Wave({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = IOS7SiriWaveformController(
      amplitude: 0.8,
      color: Colors.black,
      frequency: 6,
      speed: 0.05,
    );
    return SiriWaveform.ios7(
      controller: controller,
      options: const IOS7SiriWaveformOptions(
          height: 180,
          width: 360
      ),
    );;
  }
}
