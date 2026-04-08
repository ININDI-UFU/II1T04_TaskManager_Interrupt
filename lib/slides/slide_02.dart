import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 02 – Agenda
class Slide02 extends StatefulWidget {
  const Slide02({super.key});
  @override
  State<Slide02> createState() => _Slide02State();
}

class _Slide02State extends State<Slide02> with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
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
    final items = List.generate(
      7,
      (i) => iv(_entry, 0.15 + i * 0.08, 0.45 + i * 0.08),
    );

    const agenda = [
      ('01', 'Task Management na ESP32', kPurple),
      ('02', 'O Problema do delay()', kTeal),
      ('03', 'Controle de Tempo com millis()', kRed),
      ('04', 'Máquinas de Estado (State Machines)', kGold),
      ('05', 'Interrupções (GPIO & Timer)', kCyan),
      ('06', 'Timer vs IO Interrupt', kLavender),
      ('07', 'Código Prático (PlatformIO + ESP32)', kPurple),
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
                    'Agenda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 36 * s),
                ...List.generate(agenda.length, (i) {
                  final (num, text, color) = agenda[i];
                  return fadeReveal(
                    items[i],
                    16,
                    Padding(
                      padding: EdgeInsets.only(bottom: 14 * s),
                      child: Row(
                        children: [
                          Text(
                            num,
                            style: TextStyle(
                              color: color,
                              fontSize: 18 * s,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 16 * s),
                          Text(
                            text,
                            style: TextStyle(
                              color: kTextPrimary,
                              fontSize: 18 * s,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
