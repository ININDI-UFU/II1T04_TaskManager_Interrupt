import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 23 – Polling vs Interrupção
class Slide23 extends StatefulWidget {
  final int step;
  const Slide23({super.key, this.step = 0});
  @override
  State<Slide23> createState() => _Slide23State();
}

class _Slide23State extends State<Slide23> with SingleTickerProviderStateMixin {
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

  Widget _compPanel(
    String title,
    String desc,
    List<(String, String)> points,
    String code,
    Color color,
    double s,
  ) {
    return GlassCard(
      borderColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18 * s,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4 * s),
          Text(
            desc,
            style: TextStyle(
              color: kTextMuted,
              fontSize: 12 * s,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 14 * s),
          ...points.map(
            (p) => Padding(
              padding: EdgeInsets.only(bottom: 6 * s),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${p.$1} ', style: TextStyle(fontSize: 13 * s)),
                  Expanded(
                    child: Text(
                      p.$2,
                      style: TextStyle(
                        color: kTextPrimary,
                        fontSize: 13 * s,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10 * s),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10 * s),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0E16),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              code,
              style: TextStyle(
                color: color,
                fontSize: 12 * s,
                fontFamily: 'Consolas',
                fontWeight: FontWeight.w600,
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
                    'Polling vs Interrupção',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
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
                              child: _compPanel(
                                'Polling',
                                '"Verifica constantemente"',
                                [
                                  ('✖', 'CPU verifica a cada loop'),
                                  ('✖', 'Gasta ciclos de CPU'),
                                  ('✖', 'Pode perder eventos rápidos'),
                                  ('✖', 'Latência variável'),
                                ],
                                'if(digitalRead(BTN))',
                                kRed,
                                s,
                              ),
                            ),
                            SizedBox(width: 24 * s),
                            Expanded(
                              child: stepReveal(
                                visible: widget.step >= 1,
                                child: _compPanel(
                                  'Interrupção',
                                  '"Reage quando acontece"',
                                  [
                                    ('✔', 'CPU livre até o evento'),
                                    ('✔', 'Resposta imediata (~µs)'),
                                    ('✔', 'Nunca perde eventos'),
                                    ('✔', 'Latência baixa e constante'),
                                  ],
                                  'attachInterrupt()',
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
                              _compPanel(
                                'Polling',
                                '"Verifica constantemente"',
                                [
                                  ('✖', 'CPU verifica a cada loop'),
                                  ('✖', 'Gasta ciclos de CPU'),
                                ],
                                'if(digitalRead(BTN))',
                                kRed,
                                s,
                              ),
                              SizedBox(height: 16 * s),
                              stepReveal(
                                visible: widget.step >= 1,
                                child: _compPanel(
                                  'Interrupção',
                                  '"Reage quando acontece"',
                                  [
                                    ('✔', 'CPU livre até o evento'),
                                    ('✔', 'Resposta imediata (~µs)'),
                                  ],
                                  'attachInterrupt()',
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
