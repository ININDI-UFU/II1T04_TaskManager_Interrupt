import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 04 – FreeRTOS na ESP32
class Slide04 extends StatefulWidget {
  final int step;
  const Slide04({super.key, this.step = 0});
  @override
  State<Slide04> createState() => _Slide04State();
}

class _Slide04State extends State<Slide04> with SingleTickerProviderStateMixin {
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

    const bullets = [
      (kPurple, 'Sistema operacional de tempo real (RTOS) embutido no ESP-IDF'),
      (kTeal, 'Dual-core: PRO_CPU (Core 0) + APP_CPU (Core 1)'),
      (kGold, 'Escalonador preemptivo com prioridades (0–25)'),
      (kCyan, 'Cada task tem seu próprio stack, prioridade e estado'),
      (kRed, 'Arduino loop() roda como uma task do FreeRTOS no Core 1'),
      (kLavender, 'API principal: xTaskCreatePinnedToCore()'),
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
                    'FreeRTOS na ESP32',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34 * s,
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
                        fontSize: 16 * s,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'A ESP32 executa o '),
                        TextSpan(
                          text: 'FreeRTOS',
                          style: TextStyle(
                            color: kPurple,
                            fontWeight: FontWeight.w700,
                            fontSize: 16 * s,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' nativamente, permitindo criar múltiplas tarefas independentes',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 28 * s),
                ...List.generate(bullets.length, (i) {
                  final (color, text) = bullets[i];
                  return stepReveal(
                    visible: widget.step >= i,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 14 * s),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 8 * s,
                            height: 8 * s,
                            margin: EdgeInsets.only(top: 6 * s, right: 14 * s),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: kTextPrimary,
                                fontSize: 16 * s,
                                height: 1.4,
                              ),
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
