import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 10 – Linha do Tempo: delay() vs Não-Bloqueante
class Slide10 extends StatefulWidget {
  final int step;
  const Slide10({super.key, this.step = 0});
  @override
  State<Slide10> createState() => _Slide10State();
}

class _Slide10State extends State<Slide10> with SingleTickerProviderStateMixin {
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

  Widget _timeBlock(String label, Color color, double width, double s) {
    return Container(
      width: width,
      height: 36 * s,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10 * s,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleA = iv(_entry, 0.0, 0.35);

    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.4, 2.0);
        final bw = box.maxWidth - 120 * s;

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
                    'Linha do Tempo: delay() vs Não-Bloqueante',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),

                // COM delay()
                GlassCard(
                  borderColor: kRed,
                  padding: EdgeInsets.all(16 * s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COM delay()',
                        style: TextStyle(
                          color: kRed,
                          fontSize: 14 * s,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10 * s),
                      Row(
                        children: [
                          _timeBlock('Sensor', kPurple, bw * 0.08, s),
                          _timeBlock(
                            'delay(1000)\nBLOQUEADO',
                            kRed,
                            bw * 0.45,
                            s,
                          ),
                          _timeBlock('LED', kTeal, bw * 0.08, s),
                          _timeBlock(
                            'delay(500)\nBLOQUEADO',
                            kRed,
                            bw * 0.25,
                            s,
                          ),
                        ],
                      ),
                      SizedBox(height: 6 * s),
                      Text(
                        'CPU ociosa por longos períodos',
                        style: TextStyle(
                          color: kRed.withValues(alpha: 0.7),
                          fontSize: 11 * s,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16 * s),

                // SEM delay()
                stepReveal(
                  visible: widget.step >= 1,
                  child: GlassCard(
                    borderColor: kTeal,
                    padding: EdgeInsets.all(16 * s),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SEM delay() — Não-bloqueante',
                          style: TextStyle(
                            color: kTeal,
                            fontSize: 14 * s,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10 * s),
                        Row(
                          children: List.generate(
                            6,
                            (i) => Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 3 * s),
                                child: Column(
                                  children: [
                                    _timeBlock(
                                      'S',
                                      kPurple,
                                      double.infinity,
                                      s,
                                    ),
                                    SizedBox(height: 2 * s),
                                    _timeBlock('L', kTeal, double.infinity, s),
                                    SizedBox(height: 2 * s),
                                    _timeBlock('W', kCyan, double.infinity, s),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6 * s),
                        Text(
                          'CPU sempre produtiva, reativa',
                          style: TextStyle(
                            color: kTeal.withValues(alpha: 0.7),
                            fontSize: 11 * s,
                            fontStyle: FontStyle.italic,
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
