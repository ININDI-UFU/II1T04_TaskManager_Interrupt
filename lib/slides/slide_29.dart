import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 29 – Código: Timer Interrupt & State Machine
class Slide29 extends StatefulWidget {
  final int step;
  const Slide29({super.key, this.step = 0});
  @override
  State<Slide29> createState() => _Slide29State();
}

class _Slide29State extends State<Slide29> with SingleTickerProviderStateMixin {
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

  static const _timerCode = '''hw_timer_t *timer = NULL;
volatile bool tmrFlag = false;

void IRAM_ATTR onTimer() {
  tmrFlag = true;
}

void setup() {
  // Timer 0, prescaler 80 = 1MHz (1µs/tick)
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, &onTimer, true);
  // 1s = 1000000µs
  timerAlarmWrite(timer, 1000000, true);
  timerAlarmEnable(timer);
}''';

  static const _smCode = '''enum S { IDLE, READ, SEND };
S st = IDLE;
unsigned long prev = 0;

void loop() {
  switch(st) {
    case IDLE:
      if (millis() - prev >= 2000) {
        st = READ;
      }
      break;
    case READ:
      val = analogRead(34);
      st = SEND;
      break;
    case SEND:
      Serial.println(val);
      prev = millis();
      st = IDLE;
      break;
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
                    'Código: Timer Interrupt & State Machine',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26 * s,
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
                                    'Timer Interrupt',
                                    style: TextStyle(
                                      color: kCyan,
                                      fontSize: 13 * s,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8 * s),
                                  Expanded(
                                    child: CodeBlock(
                                      code: _timerCode,
                                      accentColor: kCyan,
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
                                      'State Machine + millis()',
                                      style: TextStyle(
                                        color: kLavender,
                                        fontSize: 13 * s,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8 * s),
                                    Expanded(
                                      child: CodeBlock(
                                        code: _smCode,
                                        accentColor: kLavender,
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
                                'Timer Interrupt',
                                style: TextStyle(
                                  color: kCyan,
                                  fontSize: 13 * s,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8 * s),
                              CodeBlock(
                                code: _timerCode,
                                accentColor: kCyan,
                                fontSize: 10 * s,
                              ),
                              SizedBox(height: 16 * s),
                              stepReveal(
                                visible: widget.step >= 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'State Machine + millis()',
                                      style: TextStyle(
                                        color: kLavender,
                                        fontSize: 13 * s,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8 * s),
                                    CodeBlock(
                                      code: _smCode,
                                      accentColor: kLavender,
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
