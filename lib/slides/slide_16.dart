import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 16 – Section: Máquinas de Estado
class Slide16 extends StatelessWidget {
  const Slide16({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionSlide(
      title: 'Máquinas de Estado',
      subtitle:
          'State Machines • if/else • switch-case • Arquitetura escalável',
      accentColor: kGold,
    );
  }
}
