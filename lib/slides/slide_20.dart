import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 20 – Nível 3: Arquitetura Escalável
class Slide20 extends StatefulWidget {
  final int step;
  const Slide20({super.key, this.step = 0});
  @override
  State<Slide20> createState() => _Slide20State();
}

class _Slide20State extends State<Slide20> with SingleTickerProviderStateMixin {
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

  Widget _archBox(String title, List<String> funcs, Color color, double s) {
    return GlassCard(
      borderColor: color,
      padding: EdgeInsets.all(14 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14 * s,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8 * s),
          ...funcs.map(
            (f) => Text(
              f,
              style: TextStyle(
                color: kTextMuted,
                fontSize: 11 * s,
                fontFamily: 'Consolas',
                height: 1.5,
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
                    'Nível 3: Arquitetura Escalável',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),
                // Main Controller
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24 * s,
                      vertical: 12 * s,
                    ),
                    decoration: BoxDecoration(
                      color: kPurple.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: kPurple.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      'Main Controller (loop)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14 * s,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: kPurple.withValues(alpha: 0.4),
                    size: 24 * s,
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * s,
                      vertical: 10 * s,
                    ),
                    decoration: BoxDecoration(
                      color: kTeal.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kTeal.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      'State Manager (switch-case)',
                      style: TextStyle(
                        color: kTeal,
                        fontSize: 13 * s,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12 * s),
                // Modules
                Expanded(
                  child: stepReveal(
                    visible: widget.step >= 1,
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _archBox(
                                  'Módulo Sensor',
                                  [
                                    'sensorInit()',
                                    'sensorRead()',
                                    'sensorProcess()',
                                  ],
                                  kPurple,
                                  s,
                                ),
                              ),
                              SizedBox(width: 12 * s),
                              Expanded(
                                child: _archBox(
                                  'Módulo Display',
                                  [
                                    'displayInit()',
                                    'displayUpdate()',
                                    'displayError()',
                                  ],
                                  kTeal,
                                  s,
                                ),
                              ),
                              SizedBox(width: 12 * s),
                              Expanded(
                                child: _archBox(
                                  'Módulo Comunicação',
                                  [
                                    'wifiConnect()',
                                    'mqttPublish()',
                                    'httpPost()',
                                  ],
                                  kGold,
                                  s,
                                ),
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                _archBox(
                                  'Módulo Sensor',
                                  ['sensorInit()', 'sensorRead()'],
                                  kPurple,
                                  s,
                                ),
                                SizedBox(height: 8 * s),
                                _archBox(
                                  'Módulo Display',
                                  ['displayInit()', 'displayUpdate()'],
                                  kTeal,
                                  s,
                                ),
                                SizedBox(height: 8 * s),
                                _archBox(
                                  'Módulo Comunicação',
                                  ['wifiConnect()', 'mqttPublish()'],
                                  kGold,
                                  s,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 10 * s),
                stepReveal(
                  visible: widget.step >= 2,
                  child: Wrap(
                    spacing: 10 * s,
                    runSpacing: 6 * s,
                    children: [
                      for (final t in [
                        '✔ Cada módulo isolado',
                        '✔ Fácil de testar',
                        '✔ Reutilizável',
                        '✔ Escalável',
                        '✔ Fácil manutenção',
                        '✔ Debug simplificado',
                      ])
                        Text(
                          t,
                          style: TextStyle(
                            color: kTeal,
                            fontSize: 12 * s,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
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
