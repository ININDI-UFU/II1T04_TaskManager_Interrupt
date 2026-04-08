import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 28 – Código: millis() & GPIO Interrupt
class Slide28 extends StatefulWidget {
  final int step;
  const Slide28({super.key, this.step = 0});
  @override
  State<Slide28> createState() => _Slide28State();
}

class _Slide28State extends State<Slide28> with SingleTickerProviderStateMixin {
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

  static const _millisCode = '''const int LED = 2;
unsigned long prev = 0;
bool state = false;

void setup() {
  pinMode(LED, OUTPUT);
}

void loop() {
  if (millis() - prev >= 500) {
    prev = millis();
    state = !state;
    digitalWrite(LED, state);
  }
}''';

  static const _gpioCode = '''volatile bool btnFlag = false;
const int BTN = 4, LED = 2;

void IRAM_ATTR isr() {
  btnFlag = true;
}

void setup() {
  pinMode(BTN, INPUT_PULLUP);
  pinMode(LED, OUTPUT);
  attachInterrupt(BTN, isr, FALLING);
}

void loop() {
  if (btnFlag) {
    btnFlag = false;
    digitalWrite(LED, !digitalRead(LED));
  }
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
                    'Código: millis() & GPIO Interrupt',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),
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
                                    'Controle com millis()',
                                    style: TextStyle(
                                      color: kTeal,
                                      fontSize: 13 * s,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8 * s),
                                  Expanded(
                                    child: CodeBlock(
                                      code: _millisCode,
                                      accentColor: kTeal,
                                      fontSize: 11 * s,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20 * s),
                            Expanded(
                              child: stepReveal(
                                visible: widget.step >= 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GPIO Interrupt',
                                      style: TextStyle(
                                        color: kGold,
                                        fontSize: 13 * s,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8 * s),
                                    Expanded(
                                      child: CodeBlock(
                                        code: _gpioCode,
                                        accentColor: kGold,
                                        fontSize: 11 * s,
                                      ),
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
                                'Controle com millis()',
                                style: TextStyle(
                                  color: kTeal,
                                  fontSize: 13 * s,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8 * s),
                              CodeBlock(
                                code: _millisCode,
                                accentColor: kTeal,
                                fontSize: 10 * s,
                              ),
                              SizedBox(height: 16 * s),
                              stepReveal(
                                visible: widget.step >= 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GPIO Interrupt',
                                      style: TextStyle(
                                        color: kGold,
                                        fontSize: 13 * s,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8 * s),
                                    CodeBlock(
                                      code: _gpioCode,
                                      accentColor: kGold,
                                      fontSize: 10 * s,
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
