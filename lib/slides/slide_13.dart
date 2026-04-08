import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 13 – Como millis() Funciona?
class Slide13 extends StatefulWidget {
  final int step;
  const Slide13({super.key, this.step = 0});
  @override
  State<Slide13> createState() => _Slide13State();
}

class _Slide13State extends State<Slide13> with SingleTickerProviderStateMixin {
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

    const steps = [
      (kPurple, '1', 'Guardar o tempoAnterior (unsigned long)'),
      (kTeal, '2', 'A cada loop, calcular: millis() - tempoAnterior'),
      (kGold, '3', 'Se diferença ≥ intervalo desejado → executar ação'),
      (kCyan, '4', 'Atualizar tempoAnterior = millis()'),
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
                    'Como millis() Funciona?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
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
                        fontSize: 15 * s,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'A função '),
                        TextSpan(
                          text: 'millis()',
                          style: TextStyle(
                            color: kGold,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Consolas',
                            fontSize: 15 * s,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' retorna o tempo em ms desde o boot. Não bloqueia nada!',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10 * s),
                fadeReveal(
                  descA,
                  10,
                  Text(
                    'Padrão fundamental:',
                    style: TextStyle(
                      color: kGold,
                      fontSize: 14 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 18 * s),
                ...List.generate(steps.length, (i) {
                  final (color, num, text) = steps[i];
                  return stepReveal(
                    visible: widget.step >= i,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 14 * s),
                      child: Row(
                        children: [
                          Container(
                            width: 32 * s,
                            height: 32 * s,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: color.withValues(alpha: 0.6),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                num,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 14 * s,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 14 * s),
                          Expanded(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: kTextPrimary,
                                fontSize: 15 * s,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16 * s),
                stepReveal(
                  visible: widget.step >= steps.length,
                  child: Container(
                    padding: EdgeInsets.all(12 * s),
                    decoration: BoxDecoration(
                      color: kGold.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kGold.withValues(alpha: 0.25)),
                    ),
                    child: Text(
                      '⚠ Tipo: unsigned long (32 bits) → overflow em ~49 dias\n'
                      'A subtração millis() - prev funciona corretamente mesmo com overflow!',
                      style: TextStyle(
                        color: kTextSecondary,
                        fontSize: 13 * s,
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
