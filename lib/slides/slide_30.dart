import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 30 – Resumo & Boas Práticas
class Slide30 extends StatefulWidget {
  final int step;
  const Slide30({super.key, this.step = 0});
  @override
  State<Slide30> createState() => _Slide30State();
}

class _Slide30State extends State<Slide30> with SingleTickerProviderStateMixin {
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

    const guide = [
      ('delay()', 'Só para debug/prototipagem rápida', kRed),
      ('millis()', 'Controle de tempo não-bloqueante', kTeal),
      ('State Machine', 'Lógica complexa + múltiplos estados', kGold),
      ('GPIO Interrupt', 'Resposta rápida a eventos externos', kCyan),
      ('Timer Interrupt', 'Amostragem precisa + watchdog', kLavender),
    ];

    const practices = [
      'ISR curta: setar flag, sair → processar no loop()',
      'Sempre volatile para variáveis entre ISR e loop()',
      'Combinar técnicas: millis() + SM + interrupt = sistema robusto',
    ];

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
                    'Resumo & Boas Práticas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),

                // Guia de Decisão
                Text(
                  'Guia de Decisão Rápida',
                  style: TextStyle(
                    color: kPurple,
                    fontSize: 15 * s,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12 * s),
                ...List.generate(guide.length, (i) {
                  final (name, desc, color) = guide[i];
                  return stepReveal(
                    visible: widget.step >= i,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8 * s),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12 * s,
                              vertical: 5 * s,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: color.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              name,
                              style: TextStyle(
                                color: color,
                                fontSize: 12 * s,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Consolas',
                              ),
                            ),
                          ),
                          SizedBox(width: 12 * s),
                          Text(
                            '→ $desc',
                            style: TextStyle(
                              color: kTextPrimary,
                              fontSize: 13 * s,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                SizedBox(height: 20 * s),

                // Boas Práticas
                stepReveal(
                  visible: widget.step >= guide.length,
                  child: GlassCard(
                    borderColor: kTeal,
                    padding: EdgeInsets.all(16 * s),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '✅ Boas Práticas',
                          style: TextStyle(
                            color: kTeal,
                            fontSize: 15 * s,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12 * s),
                        ...practices.map(
                          (p) => Padding(
                            padding: EdgeInsets.only(bottom: 8 * s),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• ',
                                  style: TextStyle(
                                    color: kTeal,
                                    fontSize: 13 * s,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    p,
                                    style: TextStyle(
                                      color: kTextPrimary,
                                      fontSize: 13 * s,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
