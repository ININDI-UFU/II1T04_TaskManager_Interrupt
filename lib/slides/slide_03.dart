import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 03 – Section: Task Management na ESP32
class Slide03 extends StatelessWidget {
  const Slide03({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionSlide(
      title: 'Task Management na ESP32',
      subtitle: 'FreeRTOS • Multitarefa • Concorrência vs Paralelismo',
      accentColor: kPurple,
    );
  }
}
