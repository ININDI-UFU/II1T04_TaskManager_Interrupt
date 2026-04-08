import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 06 – Concorrência vs Paralelismo
class Slide06 extends StatefulWidget {
  final int step;
  const Slide06({super.key, this.step = 0});
  @override
  State<Slide06> createState() => _Slide06State();
}

class _Slide06State extends State<Slide06> with SingleTickerProviderStateMixin {
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

  Widget _panel(
    String title,
    String pattern,
    List<String> items,
    Color color,
    double s,
  ) {
    return GlassCard(
      borderColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 8 * s),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16 * s,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 16 * s),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8 * s),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(color: color, fontSize: 14 * s),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: kTextPrimary,
                        fontSize: 14 * s,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12 * s),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12 * s),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              pattern,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 16 * s,
                fontWeight: FontWeight.w800,
                fontFamily: 'Consolas',
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                    'Concorrência vs Paralelismo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
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
                              child: _panel(
                                'Concorrência',
                                'A → B → A → B',
                                [
                                  '1 núcleo, múltiplas tarefas',
                                  'Tasks alternam rapidamente',
                                  'Ilusão de simultaneidade',
                                  'Time-slicing do scheduler',
                                  'Ex: ESP8266 (single-core)',
                                ],
                                kPurple,
                                s,
                              ),
                            ),
                            SizedBox(width: 24 * s),
                            Expanded(
                              child: stepReveal(
                                visible: widget.step >= 1,
                                child: _panel(
                                  'Paralelismo',
                                  'A + B (simultâneo)',
                                  [
                                    '2 núcleos, execução simultânea real',
                                    'Tasks executam ao mesmo tempo',
                                    'Verdadeira simultaneidade',
                                    'Requer hardware multi-core',
                                    'ESP32 = dual-core!',
                                  ],
                                  kTeal,
                                  s,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              _panel(
                                'Concorrência',
                                'A → B → A → B',
                                [
                                  '1 núcleo, múltiplas tarefas',
                                  'Tasks alternam rapidamente',
                                  'Ilusão de simultaneidade',
                                ],
                                kPurple,
                                s,
                              ),
                              SizedBox(height: 16 * s),
                              stepReveal(
                                visible: widget.step >= 1,
                                child: _panel(
                                  'Paralelismo',
                                  'A + B (simultâneo)',
                                  [
                                    '2 núcleos, execução simultânea',
                                    'ESP32 = dual-core!',
                                  ],
                                  kTeal,
                                  s,
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
