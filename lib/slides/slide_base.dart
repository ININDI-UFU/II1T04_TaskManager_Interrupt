import 'package:flutter/material.dart';

// ── Cores do Design System (da apresentação original) ─────────────────────
const kPurple = Color(0xFF6C63FF);
const kTeal = Color(0xFF00D9A6);
const kRed = Color(0xFFFF6B6B);
const kGold = Color(0xFFFFC857);
const kCyan = Color(0xFF4ECDC4);
const kLavender = Color(0xFFA78BFA);
const kSurface = Color(0xFF12131A);
const kSurfaceLight = Color(0xFF1C1D2B);
const kSurfaceMid = Color(0xFF22233A);
const kSurfaceCard = Color(0xFF2A2B3D);
const kTextPrimary = Color(0xFFF0F0F5);
const kTextSecondary = Color(0xFFD0D0E0);
const kTextMuted = Color(0xFFB8B8CC);
const kTextDim = Color(0xFF7B8EA2);

// ── Accents ciclando por slide ────────────────────────────────────────────
const kAccents = [kPurple, kTeal, kRed, kGold, kCyan, kLavender];

// ── DotGrid compartilhado ─────────────────────────────────────────────────
class DotGrid extends CustomPainter {
  final double s;
  const DotGrid({this.s = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.fill;
    const gap = 30.0;
    for (double x = 0; x < size.width; x += gap) {
      for (double y = 0; y < size.height; y += gap) {
        canvas.drawCircle(Offset(x, y), 0.8 * s, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DotGrid old) => old.s != s;
}

// ── Background padrão escuro com gradient ─────────────────────────────────
class SlideBackground extends StatelessWidget {
  final Widget child;
  final double scale;
  const SlideBackground({super.key, required this.child, this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0C1220), Color(0xFF090E18), Color(0xFF050810)],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: CustomPaint(painter: DotGrid(s: scale)),
          ),
          child,
        ],
      ),
    );
  }
}

// ── Helper: fade + translate reveal ───────────────────────────────────────
Widget fadeReveal(Animation<double> anim, double dy, Widget child) {
  return AnimatedBuilder(
    animation: anim,
    builder: (context, _) => Opacity(
      opacity: anim.value.clamp(0.0, 1.0),
      child: Transform.translate(
        offset: Offset(0, (1 - anim.value) * dy),
        child: child,
      ),
    ),
  );
}

// ── Helper: visibility reveal com opacity + scale ─────────────────────────
Widget stepReveal({required bool visible, required Widget child}) {
  return AnimatedOpacity(
    opacity: visible ? 1.0 : 0.0,
    duration: const Duration(milliseconds: 420),
    curve: Curves.easeOut,
    child: AnimatedScale(
      scale: visible ? 1.0 : 0.92,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutBack,
      child: IgnorePointer(ignoring: !visible, child: child),
    ),
  );
}

// ── Helper: interval animation ────────────────────────────────────────────
Animation<double> iv(AnimationController parent, double a, double b) =>
    CurvedAnimation(
      parent: parent,
      curve: Interval(a, b, curve: Curves.easeOutCubic),
    );

// ── Section Title Slide (usado em slides de seção) ────────────────────────
class SectionSlide extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color accentColor;
  const SectionSlide({
    super.key,
    required this.title,
    required this.subtitle,
    required this.accentColor,
  });

  @override
  State<SectionSlide> createState() => _SectionSlideState();
}

class _SectionSlideState extends State<SectionSlide>
    with SingleTickerProviderStateMixin {
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
    final titleA = iv(_entry, 0.0, 0.50);
    final lineA = iv(_entry, 0.25, 0.60);
    final subA = iv(_entry, 0.40, 0.80);

    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.4, 2.0);
        return SlideBackground(
          scale: s,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48 * s),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  fadeReveal(
                    titleA,
                    22 * s,
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40 * s,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        height: 1.15,
                      ),
                    ),
                  ),
                  SizedBox(height: 18 * s),
                  AnimatedBuilder(
                    animation: lineA,
                    builder: (context, _) => Container(
                      width: 300 * s * lineA.value,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: LinearGradient(
                          colors: [
                            widget.accentColor,
                            widget.accentColor.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18 * s),
                  fadeReveal(
                    subA,
                    14 * s,
                    Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextDim,
                        fontSize: 18 * s,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Glassmorphic Card ─────────────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  const GlassCard({
    super.key,
    required this.child,
    this.borderColor = kPurple,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

// ── Code Block ────────────────────────────────────────────────────────────
class CodeBlock extends StatelessWidget {
  final String code;
  final Color accentColor;
  final String? label;
  final double fontSize;
  const CodeBlock({
    super.key,
    required this.code,
    this.accentColor = kPurple,
    this.label,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0E16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                label!,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          Text(
            code,
            style: TextStyle(
              fontFamily: 'Consolas',
              fontSize: fontSize,
              color: kTextSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
