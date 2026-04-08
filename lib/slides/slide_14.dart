import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 14 – Padrão millis(): Fluxo de Execução (Fluxograma)
class Slide14 extends StatefulWidget {
  final int step;
  const Slide14({super.key, this.step = 0});
  @override
  State<Slide14> createState() => _Slide14State();
}

class _Slide14State extends State<Slide14> with SingleTickerProviderStateMixin {
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

  Widget _flowBox(
    String text,
    Color color,
    double s, {
    bool isDiamond = false,
  }) {
    if (isDiamond) {
      return Transform.rotate(
        angle: 0.785398, // 45 degrees
        child: Container(
          width: 100 * s,
          height: 100 * s,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Transform.rotate(
              angle: -0.785398,
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
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18 * s, vertical: 12 * s),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12 * s,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _arrowDown(double s, {Color color = kPurple}) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4 * s),
    child: Icon(
      Icons.arrow_downward_rounded,
      color: color.withValues(alpha: 0.5),
      size: 22 * s,
    ),
  );

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
                    'Padrão millis(): Fluxo de Execução',
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _flowBox('loop() inicia', kPurple, s),
                          _arrowDown(s),
                          stepReveal(
                            visible: widget.step >= 1,
                            child: Column(
                              children: [
                                _flowBox(
                                  'millis()-prev\n>= intervalo?',
                                  kGold,
                                  s,
                                  isDiamond: true,
                                ),
                                SizedBox(height: 8 * s),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Não
                                    Column(
                                      children: [
                                        Text(
                                          'Não',
                                          style: TextStyle(
                                            color: kRed,
                                            fontSize: 12 * s,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 4 * s),
                                        _flowBox('Continua\no loop', kRed, s),
                                        SizedBox(height: 4 * s),
                                        Text(
                                          '↻ Volta ao início',
                                          style: TextStyle(
                                            color: kRed.withValues(alpha: 0.6),
                                            fontSize: 10 * s,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 40 * s),
                                    // Sim
                                    Column(
                                      children: [
                                        Text(
                                          'SIM',
                                          style: TextStyle(
                                            color: kTeal,
                                            fontSize: 12 * s,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        _arrowDown(s, color: kTeal),
                                        _flowBox('Executar ação', kTeal, s),
                                        _arrowDown(s, color: kLavender),
                                        _flowBox(
                                          'prev = millis()',
                                          kLavender,
                                          s,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14 * s),
                          stepReveal(
                            visible: widget.step >= 2,
                            child: Container(
                              padding: EdgeInsets.all(10 * s),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'O loop() executa milhares de vezes por segundo.\n'
                                'Ação só executa quando o intervalo é atingido.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kTextMuted,
                                  fontSize: 12 * s,
                                  fontStyle: FontStyle.italic,
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
