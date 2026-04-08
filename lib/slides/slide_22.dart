import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 22 – Section: Interrupções na ESP32
class Slide22 extends StatelessWidget {
  const Slide22({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionSlide(
      title: 'Interrupções na ESP32',
      subtitle: 'GPIO Interrupts • Timer Interrupts • Polling vs Interrupt',
      accentColor: kCyan,
    );
  }
}
