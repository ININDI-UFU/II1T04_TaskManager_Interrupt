import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 09 – Por Que delay() é Prejudicial?
class Slide09 extends StatefulWidget {
  final int step;
  const Slide09({super.key, this.step = 0});
  @override
  State<Slide09> createState() => _Slide09State();
}

class _Slide09State extends State<Slide09> with SingleTickerProviderStateMixin {
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
    final descA = iv(_entry, 0.15, 0.50);

    const problems = [
      '✖  CPU fica em busy-wait (não faz NADA)',
      '✖  Sensores não são lidos durante o delay',
      '✖  Comunicação serial/WiFi fica sem resposta',
      '✖  Botões e entradas são ignorados',
      '✖  Impossível gerenciar múltiplas tarefas com tempos diferentes',
      '✖  Watchdog Timer pode resetar o ESP32',
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
                    'Por Que delay() é Prejudicial?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 12 * s),
                fadeReveal(
                  descA,
                  14,
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: kTextSecondary,
                        fontSize: 15 * s,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'O '),
                        TextSpan(
                          text: 'delay()',
                          style: TextStyle(
                            color: kRed,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Consolas',
                            fontSize: 15 * s,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' é uma função bloqueante: para TODO o processamento',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),
                ...List.generate(
                  problems.length,
                  (i) => stepReveal(
                    visible: widget.step >= i,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12 * s),
                      child: Text(
                        problems[i],
                        style: TextStyle(
                          color: kTextPrimary,
                          fontSize: 15 * s,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16 * s),
                stepReveal(
                  visible: widget.step >= problems.length,
                  child: Container(
                    padding: EdgeInsets.all(14 * s),
                    decoration: BoxDecoration(
                      color: kRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kRed.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Text('⚠', style: TextStyle(fontSize: 20 * s)),
                        SizedBox(width: 12 * s),
                        Text(
                          'delay(1000) = 1 segundo de CPU desperdiçada!',
                          style: TextStyle(
                            color: kRed,
                            fontSize: 15 * s,
                            fontWeight: FontWeight.w700,
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
      },
    );
  }
}
