import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 18 – Nível 2: switch-case (State Machine Diagram)
class Slide18 extends StatefulWidget {
  final int step;
  const Slide18({super.key, this.step = 0});
  @override
  State<Slide18> createState() => _Slide18State();
}

class _Slide18State extends State<Slide18> with SingleTickerProviderStateMixin {
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

  Widget _stateNode(String name, Color color, double s) {
    return Container(
      width: 120 * s,
      height: 50 * s,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13 * s,
            fontWeight: FontWeight.w700,
          ),
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
                    'Nível 2: switch-case',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IDLE no topo
                        _stateNode('IDLE', kPurple, s),
                        SizedBox(height: 8 * s),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Intervalo\natingido →',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: kTextMuted,
                                fontSize: 10 * s,
                                height: 1.3,
                              ),
                            ),
                            SizedBox(width: 10 * s),
                            Icon(
                              Icons.arrow_downward_rounded,
                              color: kPurple.withValues(alpha: 0.5),
                              size: 20 * s,
                            ),
                          ],
                        ),
                        SizedBox(height: 8 * s),
                        // READING
                        stepReveal(
                          visible: widget.step >= 1,
                          child: Column(
                            children: [
                              _stateNode('READING', kTeal, s),
                              SizedBox(height: 8 * s),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Leitura\ncompleta →',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: kTextMuted,
                                      fontSize: 10 * s,
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(width: 10 * s),
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kTeal.withValues(alpha: 0.5),
                                    size: 20 * s,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8 * s),
                              _stateNode('PROCESSING', kGold, s),
                              SizedBox(height: 8 * s),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Dados\nprontos →',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: kTextMuted,
                                      fontSize: 10 * s,
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(width: 10 * s),
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kGold.withValues(alpha: 0.5),
                                    size: 20 * s,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8 * s),
                              _stateNode('SENDING', kLavender, s),
                            ],
                          ),
                        ),
                        SizedBox(height: 16 * s),
                        // Centro
                        stepReveal(
                          visible: widget.step >= 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20 * s,
                              vertical: 10 * s,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Text(
                              'switch(state)',
                              style: TextStyle(
                                color: kGold,
                                fontSize: 14 * s,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Consolas',
                              ),
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
