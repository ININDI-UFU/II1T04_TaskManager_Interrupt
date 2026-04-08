import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 08 – Section: O Problema do delay()
class Slide08 extends StatelessWidget {
  const Slide08({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionSlide(
      title: 'O Problema do delay()',
      subtitle: 'Bloqueio de execução • Impacto em sistemas reativos',
      accentColor: kRed,
    );
  }
}
