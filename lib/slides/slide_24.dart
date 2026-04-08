import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 24 – Interrupção GPIO: Como Funciona
class Slide24 extends StatefulWidget {
  final int step;
  const Slide24({super.key, this.step = 0});
  @override
  State<Slide24> createState() => _Slide24State();
}

class _Slide24State extends State<Slide24> with SingleTickerProviderStateMixin {
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

  Widget _flowNode(
    String text,
    Color color,
    double s, {
    bool isCircle = false,
  }) {
    if (isCircle) {
      return Container(
        width: 70 * s,
        height: 70 * s,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.15),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10 * s,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 10 * s),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11 * s,
          fontWeight: FontWeight.w600,
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
                    'Interrupção GPIO: Como Funciona',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),
                // Flow: Botão → GPIO → ISR → loop()
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _flowNode('Botão\nPresionado', kRed, s, isCircle: true),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white24,
                          size: 24 * s,
                        ),
                        _flowNode('GPIO Pin', kPurple, s),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white24,
                          size: 24 * s,
                        ),
                        _flowNode('ISR', kGold, s),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white24,
                          size: 24 * s,
                        ),
                        _flowNode('loop()', kTeal, s),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: stepReveal(
                          visible: widget.step >= 1,
                          child: GlassCard(
                            borderColor: kGold,
                            padding: EdgeInsets.all(14 * s),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'ISR — Interrupt Service Routine',
                                  style: TextStyle(
                                    color: kGold,
                                    fontSize: 13 * s,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8 * s),
                                Text(
                                  '• Curta e rápida\n'
                                  '• Setar flag = true\n'
                                  '• Sem Serial/delay',
                                  style: TextStyle(
                                    color: kTextSecondary,
                                    fontSize: 12 * s,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16 * s),
                      Expanded(
                        child: stepReveal(
                          visible: widget.step >= 1,
                          child: GlassCard(
                            borderColor: kTeal,
                            padding: EdgeInsets.all(14 * s),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'loop() — Processamento',
                                  style: TextStyle(
                                    color: kTeal,
                                    fontSize: 13 * s,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8 * s),
                                Text(
                                  '• Verifica flag\n'
                                  '• Processa evento\n'
                                  '• Reseta flag',
                                  style: TextStyle(
                                    color: kTextSecondary,
                                    fontSize: 12 * s,
                                    height: 1.5,
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
                SizedBox(height: 10 * s),
                stepReveal(
                  visible: widget.step >= 2,
                  child: Container(
                    padding: EdgeInsets.all(10 * s),
                    decoration: BoxDecoration(
                      color: kGold.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kGold.withValues(alpha: 0.25)),
                    ),
                    child: Text(
                      '⚠ ISR deve ser IRAM_ATTR na ESP32\n'
                      '⚠ Use volatile para variáveis compartilhadas\n'
                      'Modes: RISING, FALLING, CHANGE, LOW, HIGH',
                      style: TextStyle(
                        color: kTextSecondary,
                        fontSize: 12 * s,
                        height: 1.5,
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
