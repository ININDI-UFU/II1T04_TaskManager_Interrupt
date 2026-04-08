import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 12 – Section: Controle de Tempo com millis()
class Slide12 extends StatelessWidget {
  const Slide12({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionSlide(
      title: 'Controle de Tempo com millis()',
      subtitle: 'Medir tempo sem bloquear • Execução periódica',
      accentColor: kGold,
    );
  }
}
