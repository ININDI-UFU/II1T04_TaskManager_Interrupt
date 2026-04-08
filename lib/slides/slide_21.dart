import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 21 – Comparação: Níveis de State Machine
class Slide21 extends StatefulWidget {
  final int step;
  const Slide21({super.key, this.step = 0});
  @override
  State<Slide21> createState() => _Slide21State();
}

class _Slide21State extends State<Slide21> with SingleTickerProviderStateMixin {
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

        const headers = [
          'Aspecto',
          'Nível 1:\nif+millis',
          'Nível 2:\nswitch',
          'Nível 3:\nModular',
        ];
        const rows = [
          ['Complexidade', 'Baixa', 'Média', 'Alta'],
          ['Estados', '2 (ON/OFF)', '4-8', 'Ilimitados'],
          ['Estrutura', 'if/else', 'switch-case', 'Módulos + SM'],
          ['Manutenção', '★☆☆', '★★☆', '★★★'],
          ['Escalabilidade', '★☆☆', '★★☆', '★★★'],
          ['Uso Típico', 'Blink LED', 'Controle', 'IoT completo'],
        ];

        const colColors = [kTextMuted, kPurple, kGold, kTeal];

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
                    'Comparação: Níveis de State Machine',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),
                Expanded(
                  child: GlassCard(
                    borderColor: kGold,
                    padding: EdgeInsets.all(12 * s),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1.2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        // Header
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                          ),
                          children: headers
                              .asMap()
                              .entries
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.all(8 * s),
                                  child: Text(
                                    e.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colColors[e.key],
                                      fontSize: 12 * s,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        // Data rows
                        ...rows.asMap().entries.map(
                          (row) => TableRow(
                            decoration: row.key < rows.length - 1
                                ? BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white.withValues(
                                          alpha: 0.05,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                            children: row.value
                                .asMap()
                                .entries
                                .map(
                                  (cell) => Padding(
                                    padding: EdgeInsets.all(8 * s),
                                    child: Text(
                                      cell.value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: cell.key == 0
                                            ? kTextSecondary
                                            : kTextPrimary,
                                        fontSize: 12 * s,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
