import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 27 – Timer vs GPIO Interrupt (Comparison Table)
class Slide27 extends StatefulWidget {
  final int step;
  const Slide27({super.key, this.step = 0});
  @override
  State<Slide27> createState() => _Slide27State();
}

class _Slide27State extends State<Slide27> with SingleTickerProviderStateMixin {
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

    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.4, 2.0);

        const headers = ['Característica', 'GPIO Interrupt', 'Timer Interrupt'];
        const rows = [
          [
            'Gatilho',
            'Evento externo\n(botão, sensor)',
            'Tempo decorrido\n(periódico)',
          ],
          ['Precisão', 'Depende do debounce\n~1-50ms', 'Hardware clock\n~1µs'],
          [
            'Latência',
            'Baixa (~2-5µs)\nDepende do evento',
            'Muito baixa (~1-2µs)\nPrevisível',
          ],
          [
            'Uso Típico',
            'Botões, encoders,\nSensores digitais',
            'Amostragem ADC,\nPWM, Watchdog',
          ],
          [
            'Vantagem',
            'Reativo a eventos,\nBaixo consumo',
            'Alta precisão temporal,\nDeterminístico',
          ],
          [
            'Limitação',
            'Bounce mecânico,\nRuído elétrico',
            'Nº limitado (4 timers),\nConsumo contínuo',
          ],
        ];

        return SlideBackground(
          scale: s,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40 * s, vertical: 30 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fadeReveal(
                  titleA,
                  16,
                  Text(
                    'Timer vs GPIO Interrupt',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),
                Expanded(
                  child: GlassCard(
                    borderColor: kLavender,
                    padding: EdgeInsets.all(10 * s),
                    child: SingleChildScrollView(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(1.2),
                          1: FlexColumnWidth(1.3),
                          2: FlexColumnWidth(1.3),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.15),
                                ),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8 * s),
                                child: Text(
                                  headers[0],
                                  style: TextStyle(
                                    color: kTextMuted,
                                    fontSize: 11 * s,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8 * s),
                                child: Text(
                                  headers[1],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kCyan,
                                    fontSize: 11 * s,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8 * s),
                                child: Text(
                                  headers[2],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kLavender,
                                    fontSize: 11 * s,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ...rows.map(
                            (row) => TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.05),
                                  ),
                                ),
                              ),
                              children: row
                                  .asMap()
                                  .entries
                                  .map(
                                    (cell) => Padding(
                                      padding: EdgeInsets.all(8 * s),
                                      child: Text(
                                        cell.value,
                                        textAlign: cell.key == 0
                                            ? TextAlign.left
                                            : TextAlign.center,
                                        style: TextStyle(
                                          color: cell.key == 0
                                              ? kTextSecondary
                                              : kTextPrimary,
                                          fontSize: 11 * s,
                                          height: 1.3,
                                          fontWeight: cell.key == 0
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
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
