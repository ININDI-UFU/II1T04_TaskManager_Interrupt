import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../utils/fullscreen_util.dart';
import '../slides/slide_base.dart';
import '../slides/slide_01.dart';
import '../slides/slide_02.dart';
import '../slides/slide_03.dart';
import '../slides/slide_04.dart';
import '../slides/slide_05.dart';
import '../slides/slide_06.dart';
import '../slides/slide_07.dart';
import '../slides/slide_08.dart';
import '../slides/slide_09.dart';
import '../slides/slide_10.dart';
import '../slides/slide_11.dart';
import '../slides/slide_12.dart';
import '../slides/slide_13.dart';
import '../slides/slide_14.dart';
import '../slides/slide_15.dart';
import '../slides/slide_16.dart';
import '../slides/slide_17.dart';
import '../slides/slide_18.dart';
import '../slides/slide_19.dart';
import '../slides/slide_20.dart';
import '../slides/slide_21.dart';
import '../slides/slide_22.dart';
import '../slides/slide_23.dart';
import '../slides/slide_24.dart';
import '../slides/slide_25.dart';
import '../slides/slide_26.dart';
import '../slides/slide_27.dart';
import '../slides/slide_28.dart';
import '../slides/slide_29.dart';
import '../slides/slide_30.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fullscreen_button.dart';

class PresentationScreen extends StatefulWidget {
  final int initialSlide;
  const PresentationScreen({super.key, this.initialSlide = 1});
  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with TickerProviderStateMixin {
  late int _currentSlide;
  int _subStep = 0;
  bool _isFullscreen = false;
  final _focusNode = FocusNode();

  // glow / corner-bracket animations
  late final AnimationController _glowCtrl;
  late final AnimationController _bracketCtrl;

  // badge bounce for slide number
  late final AnimationController _badgeCtrl;

  static const _maxSubStep = <int, int>{
    4: 6,
    5: 1,
    6: 1,
    7: 1,
    9: 7,
    10: 1,
    11: 1,
    13: 5,
    14: 2,
    15: 3,
    17: 1,
    18: 2,
    19: 0,
    20: 2,
    21: 0,
    23: 1,
    24: 2,
    25: 5,
    27: 0,
    28: 1,
    29: 1,
    30: 6,
  };

  @override
  void initState() {
    super.initState();
    _currentSlide = widget.initialSlide.clamp(1, kTotalSlides);

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _bracketCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _badgeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _glowCtrl.dispose();
    _bracketCtrl.dispose();
    _badgeCtrl.dispose();
    super.dispose();
  }

  // ── navigation ──
  void _goTo(int slide) {
    if (slide < 1 || slide > kTotalSlides) return;
    setState(() {
      _currentSlide = slide;
      _subStep = 0;
      _bracketCtrl.forward(from: 0);
      _badgeCtrl.forward(from: 0);
    });
    Navigator.of(context).pushReplacementNamed('/$slide');
  }

  void _next() {
    final max = _maxSubStep[_currentSlide] ?? 0;
    if (_subStep < max) {
      setState(() => _subStep++);
    } else {
      _goTo(_currentSlide + 1);
    }
  }

  void _prev() {
    if (_subStep > 0) {
      setState(() => _subStep--);
    } else {
      _goTo(_currentSlide - 1);
    }
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) return;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.pageDown:
        _next();
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.pageUp:
        _prev();
      case LogicalKeyboardKey.home:
        _goTo(1);
      case LogicalKeyboardKey.end:
        _goTo(kTotalSlides);
      default:
        break;
    }
  }

  // ── accent color cycling ──
  Color get _accent => kAccents[_currentSlide % kAccents.length];

  // ── slide builder ──
  Widget _buildSlide() {
    switch (_currentSlide) {
      case 1:
        return const Slide01();
      case 2:
        return const Slide02();
      case 3:
        return const Slide03();
      case 4:
        return Slide04(step: _subStep);
      case 5:
        return Slide05(step: _subStep);
      case 6:
        return Slide06(step: _subStep);
      case 7:
        return Slide07(step: _subStep);
      case 8:
        return const Slide08();
      case 9:
        return Slide09(step: _subStep);
      case 10:
        return Slide10(step: _subStep);
      case 11:
        return Slide11(step: _subStep);
      case 12:
        return const Slide12();
      case 13:
        return Slide13(step: _subStep);
      case 14:
        return Slide14(step: _subStep);
      case 15:
        return Slide15(step: _subStep);
      case 16:
        return const Slide16();
      case 17:
        return Slide17(step: _subStep);
      case 18:
        return Slide18(step: _subStep);
      case 19:
        return Slide19(step: _subStep);
      case 20:
        return Slide20(step: _subStep);
      case 21:
        return Slide21(step: _subStep);
      case 22:
        return const Slide22();
      case 23:
        return Slide23(step: _subStep);
      case 24:
        return Slide24(step: _subStep);
      case 25:
        return Slide25(step: _subStep);
      case 26:
        return const Slide26();
      case 27:
        return Slide27(step: _subStep);
      case 28:
        return Slide28(step: _subStep);
      case 29:
        return Slide29(step: _subStep);
      case 30:
        return Slide30(step: _subStep);
      default:
        return const Slide01();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKey,
      child: Scaffold(
        backgroundColor: const Color(0xFF12131A),
        body: Stack(
          children: [
            // ── animated glow ──
            AnimatedBuilder(
              animation: _glowCtrl,
              builder: (_, _) {
                return Positioned(
                  top: -120,
                  left: -120,
                  child: Container(
                    width: 360,
                    height: 360,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _accent.withValues(
                            alpha: 0.08 + _glowCtrl.value * 0.06,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // ── slide content ──
            Positioned.fill(
              bottom: 54,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: KeyedSubtree(
                  key: ValueKey('$_currentSlide-$_subStep'),
                  child: _buildSlide(),
                ),
              ),
            ),

            // ── corner brackets ──
            ..._buildBrackets(),

            // ── badge (slide number) ──
            Positioned(
              top: 16,
              left: 16,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _badgeCtrl,
                  curve: Curves.elasticOut,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _accent.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    '$_currentSlide / $kTotalSlides',
                    style: TextStyle(
                      color: _accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            // ── fullscreen button ──
            Positioned(
              top: 16,
              right: 110,
              child: FullscreenButton(
                isFullscreen: _isFullscreen,
                onTap: () {
                  toggleFullscreen();
                  setState(() => _isFullscreen = !_isFullscreen);
                },
              ),
            ),

            // ── bottom nav ──
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavBar(
                currentSlide: _currentSlide - 1,
                totalSlides: kTotalSlides,
                onPrev: _prev,
                onNext: _next,
                onJump: (i) => _goTo(i + 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── corner bracket helpers ──
  List<Widget> _buildBrackets() {
    const bLen = 30.0;
    const bThick = 2.0;
    final color = _accent.withValues(alpha: 0.3);
    final anim = CurvedAnimation(parent: _bracketCtrl, curve: Curves.easeOut);

    Widget bracket(Alignment align) {
      final isTop = align.y < 0;
      final isLeft = align.x < 0;
      return Positioned(
        top: isTop ? 8 : null,
        bottom: isTop ? null : 60,
        left: isLeft ? 8 : null,
        right: isLeft ? null : 8,
        child: FadeTransition(
          opacity: anim,
          child: SizedBox(
            width: bLen,
            height: bLen,
            child: CustomPaint(
              painter: _BracketPainter(
                color: color,
                thickness: bThick,
                align: align,
              ),
            ),
          ),
        ),
      );
    }

    return [
      bracket(Alignment.topLeft),
      bracket(Alignment.topRight),
      bracket(Alignment.bottomLeft),
      bracket(Alignment.bottomRight),
    ];
  }
}

class _BracketPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final Alignment align;
  _BracketPainter({
    required this.color,
    required this.thickness,
    required this.align,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    if (align == Alignment.topLeft) {
      path.moveTo(0, h);
      path.lineTo(0, 0);
      path.lineTo(w, 0);
    } else if (align == Alignment.topRight) {
      path.moveTo(0, 0);
      path.lineTo(w, 0);
      path.lineTo(w, h);
    } else if (align == Alignment.bottomLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, h);
      path.lineTo(w, h);
    } else {
      path.moveTo(0, h);
      path.lineTo(w, h);
      path.lineTo(w, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BracketPainter old) =>
      old.color != color || old.thickness != thickness;
}
