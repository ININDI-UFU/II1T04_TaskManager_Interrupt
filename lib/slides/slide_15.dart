import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 15 – Aplicações Práticas de millis()
class Slide15 extends StatefulWidget {
  final int step;
  const Slide15({super.key, this.step = 0});
  @override
  State<Slide15> createState() => _Slide15State();
}

class _Slide15State extends State<Slide15> with SingleTickerProviderStateMixin {
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

    const apps = [
      (
        '💡',
        'Piscar LED sem bloquear',
        'Intervalo de 500ms, LED alterna HIGH/LOW\nEnquanto isso, outras tarefas continuam rodando',
        kPurple,
      ),
      (
        '🌡',
        'Leitura periódica de sensor',
        'DHT22 a cada 2s, BMP280 a cada 500ms\nCada sensor com seu próprio tempoAnterior',
        kTeal,
      ),
      (
        '⚙',
        'Controle de processo industrial',
        'PID a cada 100ms + log a cada 5s + display a cada 1s\nCada subsistema opera no seu tempo',
        kGold,
      ),
    ];

    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.4, 2.0);

        return SlideBackground(
          scale: s,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60 * s, vertical: 40 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fadeReveal(
                  titleA,
                  20,
                  Text(
                    'Aplicações Práticas de millis()',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 28 * s),
                ...List.generate(apps.length, (i) {
                  final (icon, title, desc, color) = apps[i];
                  return stepReveal(
                    visible: widget.step >= i,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 18 * s),
                      child: GlassCard(
                        borderColor: color,
                        padding: EdgeInsets.all(18 * s),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(icon, style: TextStyle(fontSize: 28 * s)),
                            SizedBox(width: 16 * s),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 16 * s,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 6 * s),
                                  Text(
                                    desc,
                                    style: TextStyle(
                                      color: kTextSecondary,
                                      fontSize: 13 * s,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
