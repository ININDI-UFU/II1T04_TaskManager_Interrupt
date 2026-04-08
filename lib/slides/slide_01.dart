import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 01 – Capa: Gerenciamento de Tarefas, Tempo e Estados na ESP32
class Slide01 extends StatefulWidget {
  const Slide01({super.key});
  @override
  State<Slide01> createState() => _Slide01State();
}

class _Slide01State extends State<Slide01> with TickerProviderStateMixin {
  late final AnimationController _entry;
  late final AnimationController _glow;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
    _glow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entry.dispose();
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chipA = iv(_entry, 0.00, 0.45);
    final titleA = iv(_entry, 0.20, 0.60);
    final lineA = iv(_entry, 0.35, 0.65);
    final subA = iv(_entry, 0.45, 0.75);
    final badgeA = iv(_entry, 0.60, 1.00);
    final glowA = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _glow, curve: Curves.easeInOut));

    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.3, 2.5);

        return SlideBackground(
          scale: s,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Glow radial
              AnimatedBuilder(
                animation: glowA,
                builder: (context, _) => Center(
                  child: Container(
                    width: 500 * s,
                    height: 500 * s,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          kPurple.withValues(alpha: 0.08 * glowA.value),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Conteúdo central
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48 * s),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Chip ESP32
                      fadeReveal(
                        chipA,
                        -28 * s,
                        AnimatedBuilder(
                          animation: glowA,
                          builder: (context, _) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28 * s,
                              vertical: 14 * s,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: kPurple.withValues(alpha: 0.12),
                              border: Border.all(
                                color: kPurple.withValues(
                                  alpha: 0.3 + 0.15 * glowA.value,
                                ),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: kPurple.withValues(
                                    alpha: 0.15 * glowA.value,
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Text(
                              'ESP32',
                              style: TextStyle(
                                color: kPurple,
                                fontSize: 18 * s,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Consolas',
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32 * s),

                      // Título
                      fadeReveal(
                        titleA,
                        22 * s,
                        Text(
                          'Gerenciamento de Tarefas,\nTempo e Estados na ESP32',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40 * s,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.8,
                            height: 1.15,
                          ),
                        ),
                      ),

                      SizedBox(height: 18 * s),

                      // Linha gradiente
                      AnimatedBuilder(
                        animation: lineA,
                        builder: (context, _) => Container(
                          width: 320 * s * lineA.value,
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            gradient: const LinearGradient(
                              colors: [kPurple, kTeal],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 18 * s),

                      // Subtítulo
                      fadeReveal(
                        subA,
                        14 * s,
                        Text(
                          'FreeRTOS • millis() • State Machines • Interrupções',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kTextDim,
                            fontSize: 17 * s,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      SizedBox(height: 36 * s),

                      // Badge inferior
                      fadeReveal(
                        badgeA,
                        12 * s,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * s,
                            vertical: 10 * s,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withValues(alpha: 0.05),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            'Instrumentação Industrial I',
                            style: TextStyle(
                              color: kTextMuted,
                              fontSize: 13 * s,
                              fontWeight: FontWeight.w400,
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
        );
      },
    );
  }
}
