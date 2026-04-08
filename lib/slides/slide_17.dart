import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 17 – Nível 1: if + millis()
class Slide17 extends StatefulWidget {
  final int step;
  const Slide17({super.key, this.step = 0});
  @override
  State<Slide17> createState() => _Slide17State();
}

class _Slide17State extends State<Slide17> with SingleTickerProviderStateMixin {
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

  static const _code = '''bool ledState = false;
unsigned long prev = 0;

void loop() {
  if (millis() - prev >= 1000) {
    prev = millis();
    ledState = !ledState;
    digitalWrite(LED, ledState);
  }
}''';

  @override
  Widget build(BuildContext context) {
    final titleA = iv(_entry, 0.0, 0.35);

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
                    'Nível 1: if + millis()',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10 * s),
                fadeReveal(
                  iv(_entry, 0.15, 0.50),
                  14,
                  Text(
                    'Abordagem mais simples: variável de estado + if/else + millis()',
                    style: TextStyle(
                      color: kTextSecondary,
                      fontSize: 15 * s,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600 * s),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CodeBlock(
                            code: _code,
                            accentColor: kGold,
                            label: 'C++ / ARDUINO',
                            fontSize: 13 * s,
                          ),
                          SizedBox(height: 16 * s),
                          stepReveal(
                            visible: widget.step >= 1,
                            child: Container(
                              padding: EdgeInsets.all(12 * s),
                              decoration: BoxDecoration(
                                color: kTeal.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: kTeal.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                '✔ Simples, funciona para 2 estados (ON/OFF, IDLE/RUN)',
                                style: TextStyle(
                                  color: kTeal,
                                  fontSize: 14 * s,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
