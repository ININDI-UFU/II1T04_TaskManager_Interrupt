import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 25 – Interrupção por Timer
class Slide25 extends StatefulWidget {
  final int step;
  const Slide25({super.key, this.step = 0});
  @override
  State<Slide25> createState() => _Slide25State();
}

class _Slide25State extends State<Slide25> with SingleTickerProviderStateMixin {
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

    const chars = [
      (kPurple, '4 timers de hardware (64 bits cada)'),
      (kTeal, 'Clock base: 80 MHz (prescaler configurável)'),
      (kGold, 'Precisão de microsegundos'),
      (kCyan, 'Modo: auto-reload (periódico) ou one-shot'),
    ];

    const uses = [
      (kLavender, 'Amostragem precisa de ADC (ex: 10kHz)'),
      (kPurple, 'Geração de PWM por software'),
      (kTeal, 'Watchdog personalizado, timeout de comunicação'),
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
                    'Interrupção por Timer',
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
                  Text(
                    'Timer Interrupts geram interrupções em intervalos precisos de hardware',
                    style: TextStyle(
                      color: kTextSecondary,
                      fontSize: 15 * s,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),
                Text(
                  'Características da ESP32:',
                  style: TextStyle(
                    color: kCyan,
                    fontSize: 14 * s,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12 * s),
                ...List.generate(chars.length, (i) {
                  final (color, text) = chars[i];
                  return stepReveal(
                    visible: widget.step >= i,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10 * s),
                      child: Row(
                        children: [
                          Container(
                            width: 7 * s,
                            height: 7 * s,
                            margin: EdgeInsets.only(right: 12 * s),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            text,
                            style: TextStyle(
                              color: kTextPrimary,
                              fontSize: 14 * s,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20 * s),
                stepReveal(
                  visible: widget.step >= chars.length,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Uso típico:',
                        style: TextStyle(
                          color: kLavender,
                          fontSize: 14 * s,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10 * s),
                      ...uses.map(
                        (u) => Padding(
                          padding: EdgeInsets.only(bottom: 8 * s),
                          child: Row(
                            children: [
                              Container(
                                width: 7 * s,
                                height: 7 * s,
                                margin: EdgeInsets.only(right: 12 * s),
                                decoration: BoxDecoration(
                                  color: u.$1,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                u.$2,
                                style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 14 * s,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
