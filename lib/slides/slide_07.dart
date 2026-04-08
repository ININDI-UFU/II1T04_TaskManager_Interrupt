import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 07 – Quando Usar Multitarefa?
class Slide07 extends StatefulWidget {
  final int step;
  const Slide07({super.key, this.step = 0});
  @override
  State<Slide07> createState() => _Slide07State();
}

class _Slide07State extends State<Slide07> with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleA = iv(_entry, 0.0, 0.35);

    const useItems = [
      'Precisa ler sensores E comunicar WiFi simultaneamente',
      'Tarefas com períodos diferentes (100ms, 1s, 5s)',
      'Uma operação lenta não pode travar as outras',
    ];

    const avoidItems = [
      'Projeto simples com uma única lógica sequencial',
      'RAM limitada (cada task consome ~2-8KB de stack)',
      'millis() + máquina de estados já resolve o problema',
    ];

    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.4, 2.0);
        final isWide = box.maxWidth > 700;

        Widget buildList(
          String icon,
          String title,
          List<String> items,
          Color color,
          bool visible,
        ) {
          return stepReveal(
            visible: visible,
            child: GlassCard(
              borderColor: color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(icon, style: TextStyle(fontSize: 20 * s)),
                      SizedBox(width: 10 * s),
                      Text(
                        title,
                        style: TextStyle(
                          color: color,
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14 * s),
                  ...items.map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 10 * s),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(color: color, fontSize: 14 * s),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: kTextPrimary,
                                fontSize: 14 * s,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SlideBackground(
          scale: s,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50 * s, vertical: 30 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fadeReveal(
                  titleA,
                  16,
                  Text(
                    'Quando Usar Multitarefa?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),
                Expanded(
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: buildList(
                                '✔',
                                'Use multitarefa quando:',
                                useItems,
                                kTeal,
                                true,
                              ),
                            ),
                            SizedBox(width: 24 * s),
                            Expanded(
                              child: buildList(
                                '✘',
                                'Evite multitarefa quando:',
                                avoidItems,
                                kRed,
                                widget.step >= 1,
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              buildList(
                                '✔',
                                'Use multitarefa quando:',
                                useItems,
                                kTeal,
                                true,
                              ),
                              SizedBox(height: 16 * s),
                              buildList(
                                '✘',
                                'Evite multitarefa quando:',
                                avoidItems,
                                kRed,
                                widget.step >= 1,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
