import 'package:flutter/material.dart';
import 'slide_base.dart';

/// Slide 05 – Tasks vs Loop Tradicional
class Slide05 extends StatefulWidget {
  final int step;
  const Slide05({super.key, this.step = 0});
  @override
  State<Slide05> createState() => _Slide05State();
}

class _Slide05State extends State<Slide05> with SingleTickerProviderStateMixin {
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

  Widget _buildSeqPanel(double s) {
    return GlassCard(
      borderColor: kRed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Loop Tradicional (Sequencial)', kRed, s),
          SizedBox(height: 14 * s),
          _seqStep('Ler Sensor', '(bloqueado durante delay)', kRed, s),
          _arrow(s),
          _seqStep('Atualizar Display', '(espera anterior terminar)', kRed, s),
          _arrow(s),
          _seqStep('Enviar WiFi', '(tudo parado)', kRed, s),
        ],
      ),
    );
  }

  Widget _buildParPanel(double s) {
    return GlassCard(
      borderColor: kTeal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('FreeRTOS Tasks (Paralelo)', kTeal, s),
          SizedBox(height: 14 * s),
          _taskCard(
            'Task 1: Ler Sensor',
            'Executa independente\nPrioridade: Alta',
            kPurple,
            s,
          ),
          SizedBox(height: 10 * s),
          _taskCard(
            'Task 2: Atualizar Display',
            'Executa independente\nPrioridade: Média',
            kTeal,
            s,
          ),
          SizedBox(height: 10 * s),
          _taskCard(
            'Task 3: Enviar WiFi',
            'Executa independente\nPrioridade: Baixa',
            kCyan,
            s,
          ),
        ],
      ),
    );
  }

  Widget _label(String text, Color color, double s) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 6 * s),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14 * s,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  Widget _seqStep(String title, String sub, Color color, double s) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(12 * s),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13 * s,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          sub,
          style: TextStyle(color: kTextMuted, fontSize: 11 * s),
        ),
      ],
    ),
  );

  Widget _arrow(double s) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4 * s),
    child: Center(
      child: Icon(
        Icons.arrow_downward_rounded,
        color: kRed.withValues(alpha: 0.5),
        size: 20 * s,
      ),
    ),
  );

  Widget _taskCard(String title, String sub, Color color, double s) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12 * s),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13 * s,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4 * s),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: TextStyle(color: kTextMuted, fontSize: 11 * s),
            ),
          ],
        ),
      );

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
                    'Tasks vs Loop Tradicional',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 24 * s),
                Expanded(
                  child: isWide
                      ? Row(
                          children: [
                            Expanded(
                              child: stepReveal(
                                visible: true,
                                child: _buildSeqPanel(s),
                              ),
                            ),
                            SizedBox(width: 20 * s),
                            // VS badge
                            stepReveal(
                              visible: widget.step >= 1,
                              child: Container(
                                width: 48 * s,
                                height: 48 * s,
                                decoration: BoxDecoration(
                                  color: kGold,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    'VS',
                                    style: TextStyle(
                                      color: kSurface,
                                      fontSize: 16 * s,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20 * s),
                            Expanded(
                              child: stepReveal(
                                visible: widget.step >= 1,
                                child: _buildParPanel(s),
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildSeqPanel(s),
                              SizedBox(height: 16 * s),
                              stepReveal(
                                visible: widget.step >= 1,
                                child: _buildParPanel(s),
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
