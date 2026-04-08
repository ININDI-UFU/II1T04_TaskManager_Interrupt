import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 11 – Código: delay() vs millis()
class Slide11 extends StatefulWidget {
  final int step;
  const Slide11({super.key, this.step = 0});
  @override
  State<Slide11> createState() => _Slide11State();
}

class _Slide11State extends State<Slide11> with SingleTickerProviderStateMixin {
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

  static const _delayCode = '''void loop() {
  lerSensor();       // 100ms
  delay(1000);       // TRAVA 1s!
  atualizarLED();    // 100ms
  delay(1000);       // TRAVA 1s!
}
// 2s de CPU desperdiçada por ciclo''';

  static const _millisCode = '''unsigned long prev = 0;
const long intervalo = 1000;

void loop() {
  if (millis() - prev >= intervalo) {
    prev = millis();
    lerSensor();
    atualizarLED();
  }
  // CPU livre entre execuções!
}''';

  @override
  Widget build(BuildContext context) {
    final titleA = iv(_entry, 0.0, 0.35);

    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.4, 2.0);
        final isWide = box.maxWidth > 700;

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
                    'Código: delay() vs millis()',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 * s,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '✘ Com delay()',
                                    style: TextStyle(
                                      color: kRed,
                                      fontSize: 14 * s,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 10 * s),
                                  CodeBlock(
                                    code: _delayCode,
                                    accentColor: kRed,
                                    fontSize: 12 * s,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24 * s),
                            Expanded(
                              child: stepReveal(
                                visible: widget.step >= 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '✔ Com millis()',
                                      style: TextStyle(
                                        color: kTeal,
                                        fontSize: 14 * s,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10 * s),
                                    CodeBlock(
                                      code: _millisCode,
                                      accentColor: kTeal,
                                      fontSize: 12 * s,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '✘ Com delay()',
                                style: TextStyle(
                                  color: kRed,
                                  fontSize: 14 * s,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10 * s),
                              CodeBlock(
                                code: _delayCode,
                                accentColor: kRed,
                                fontSize: 11 * s,
                              ),
                              SizedBox(height: 20 * s),
                              stepReveal(
                                visible: widget.step >= 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '✔ Com millis()',
                                      style: TextStyle(
                                        color: kTeal,
                                        fontSize: 14 * s,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10 * s),
                                    CodeBlock(
                                      code: _millisCode,
                                      accentColor: kTeal,
                                      fontSize: 11 * s,
                                    ),
                                  ],
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
