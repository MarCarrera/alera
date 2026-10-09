import 'dart:math' as math;

import 'package:flutter/material.dart';

class SuccessAnimatedIcon extends StatefulWidget {
  const SuccessAnimatedIcon({
    super.key,
    required this.color,
    this.size = 72,
  });

  final Color color;
  final double size;

  @override
  State<SuccessAnimatedIcon> createState() =>
      _SuccessAnimatedIconState();
}

class _SuccessAnimatedIconState
    extends State<SuccessAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _haloProgress;
  late final Animation<double> _coreScale;
  late final Animation<double> _glyphProgress;
  late final Animation<double> _lockScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 840,
      ),
    );

    // Halo exterior.
    _haloProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.42,
        curve: Curves.easeOutCubic,
      ),
    );

    // Círculo central.
    _coreScale = Tween<double>(
      begin: 0.55,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.12,
          0.52,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    // Entrada del check.
    _glyphProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.38,
        0.78,
        curve: Curves.easeOutBack,
      ),
    );

    // Microimpacto final.
    _lockScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.05,
        ),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.07,
          end: 0.98,
        ),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.98,
          end: 1.0,
        ),
        weight: 35,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.72,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: _SuccessIconPainter(
            color: widget.color,
            haloProgress: _haloProgress.value,
            coreScale: _coreScale.value,
            glyphProgress: _glyphProgress.value,
            lockScale: _lockScale.value,
          ),
        );
      },
    );
  }
}

class _SuccessIconPainter extends CustomPainter {
  const _SuccessIconPainter({
    required this.color,
    required this.haloProgress,
    required this.coreScale,
    required this.glyphProgress,
    required this.lockScale,
  });

  final Color color;

  final double haloProgress;
  final double coreScale;
  final double glyphProgress;
  final double lockScale;

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    _drawHalo(
      canvas,
      size,
      center,
    );

    canvas.save();

    canvas.translate(
      center.dx,
      center.dy,
    );

    canvas.scale(
      coreScale * lockScale,
    );

    canvas.translate(
      -center.dx,
      -center.dy,
    );

    _drawCore(
      canvas,
      size,
      center,
    );

    _drawCheck(
      canvas,
      size,
      center,
    );

    canvas.restore();
  }

  void _drawHalo(
    Canvas canvas,
    Size size,
    Offset center,
  ) {
    if (haloProgress <= 0) {
      return;
    }

    final radius = size.width * 0.45;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final haloPaint = Paint()
      ..color = color.withValues(
        alpha: 0.22 * haloProgress,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round;

    final startAngle =
        (-math.pi / 2) +
        (haloProgress * math.pi * 0.75);

    final sweepAngle =
        math.pi *
        1.55 *
        haloProgress;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      haloPaint,
    );
  }

  void _drawCore(
    Canvas canvas,
    Size size,
    Offset center,
  ) {
    final radius = size.width * 0.35;

    final corePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      center,
      radius,
      corePaint,
    );
  }

  void _drawCheck(
    Canvas canvas,
    Size size,
    Offset center,
  ) {
    if (glyphProgress <= 0) {
      return;
    }

    final progress = glyphProgress.clamp(
      0.0,
      1.0,
    );

    final translateY = _lerp(
      size.height * 0.14,
      0,
      progress,
    );

    final rotation = _lerp(
      -0.22,
      0,
      progress,
    );

    final scale = _lerp(
      0.60,
      1.0,
      progress,
    );

    canvas.save();

    canvas.translate(
      center.dx,
      center.dy + translateY,
    );

    canvas.rotate(rotation);

    canvas.scale(scale);

    canvas.translate(
      -center.dx,
      -center.dy,
    );

    final checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.085
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(
        size.width * 0.30,
        size.height * 0.52,
      )
      ..lineTo(
        size.width * 0.44,
        size.height * 0.65,
      )
      ..lineTo(
        size.width * 0.72,
        size.height * 0.37,
      );

    canvas.drawPath(
      path,
      checkPaint,
    );

    canvas.restore();
  }

  double _lerp(
    double begin,
    double end,
    double progress,
  ) {
    return begin +
        ((end - begin) * progress);
  }

  @override
  bool shouldRepaint(
    covariant _SuccessIconPainter oldDelegate,
  ) {
    return oldDelegate.color != color ||
        oldDelegate.haloProgress != haloProgress ||
        oldDelegate.coreScale != coreScale ||
        oldDelegate.glyphProgress != glyphProgress ||
        oldDelegate.lockScale != lockScale;
  }
}