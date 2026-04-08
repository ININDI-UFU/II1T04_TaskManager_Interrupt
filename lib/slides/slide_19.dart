import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 19 – Código: switch-case State Machine
class Slide19 extends StatefulWidget {
  final int step;
  const Slide19({super.key, this.step = 0});
  @override
  State<Slide19> createState() => _Slide19State();
}

class _Slide19State extends State<Slide19> with SingleTickerProviderStateMixin {
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

  static const _code = '''enum State { IDLE, READING, PROCESSING, SENDING };
State state = IDLE;

void loop() {
  switch(state) {
    case IDLE:
      if (millis() - prev >= 2000) {
        state = READING;
      }
      break;
    case READING:
      valor = analogRead(SENSOR);
      state = PROCESSING;
      break;
    case PROCESSING:
      resultado = calcular(valor);
      state = SENDING;
      break;
    case SENDING:
      enviarWiFi(resultado);
      prev = millis();
      state = IDLE;
      break;
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
            padding: EdgeInsets.symmetric(horizontal: 60 * s, vertical: 30 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fadeReveal(
                  titleA,
                  16,
                  Text(
                    'Código: switch-case State Machine',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 650 * s),
                      child: CodeBlock(
                        code: _code,
                        accentColor: kGold,
                        label: 'C++ / ARDUINO',
                        fontSize: 12 * s,
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
