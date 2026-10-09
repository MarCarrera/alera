import 'dart:math' as math;

import 'package:flutter/material.dart';

class ErrorAnimatedIcon extends StatefulWidget {
  const ErrorAnimatedIcon({
    super.key,
    required this.color,
    this.size = 72,
  });

  final Color color;
  final double size;

  @override
  State<ErrorAnimatedIcon> createState() =>
      _ErrorAnimatedIconState();
}

class _ErrorAnimatedIconState
    extends State<ErrorAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _haloProgress;
  late final Animation<double> _coreScale;
  late final Animation<double> _glyphProgress;
  late final Animation<double> _impactProgress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    );

    _haloProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.35,
        curve: Curves.easeOutCubic,
      ),
    );

    _coreScale = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.08,
          0.45,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    _glyphProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.28,
        0.62,
        curve: Curves.easeOutCubic,
      ),
    );

    _impactProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.58,
        1.0,
        curve: Curves.easeOut,
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
          painter: _ErrorIconPainter(
            color: widget.color,
            haloProgress: _haloProgress.value,
            coreScale: _coreScale.value,
            glyphProgress: _glyphProgress.value,
            impactProgress: _impactProgress.value,
          ),
        );
      },
    );
  }
}

class _ErrorIconPainter extends CustomPainter {
  const _ErrorIconPainter({
    required this.color,
    required this.haloProgress,
    required this.coreScale,
    required this.glyphProgress,
    required this.impactProgress,
  });

  final Color color;
  final double haloProgress;
  final double coreScale;
  final double glyphProgress;
  final double impactProgress;

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

    final scaleX = _resolveScaleX();
    final scaleY = _resolveScaleY();

    canvas.save();

    canvas.translate(
      center.dx,
      center.dy,
    );

    canvas.scale(
      coreScale * scaleX,
      coreScale * scaleY,
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

    _drawExclamation(
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
        alpha: 0.20 * haloProgress,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round;

    final startAngle =
        (-math.pi / 2) -
        (haloProgress * math.pi * 0.20);

    final sweepAngle =
        math.pi *
        1.65 *
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

  void _drawExclamation(
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
      -size.height * 0.18,
      0,
      progress,
    );

    final scale = _lerp(
      0.75,
      1.0,
      progress,
    );

    canvas.save();

    canvas.translate(
      center.dx,
      center.dy + translateY,
    );

    canvas.scale(scale);

    canvas.translate(
      -center.dx,
      -center.dy,
    );

    final glyphPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final lineRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.465,
        size.height * 0.31,
        size.width * 0.07,
        size.height * 0.29,
      ),
      Radius.circular(
        size.width * 0.035,
      ),
    );

    canvas.drawRRect(
      lineRect,
      glyphPaint,
    );

    canvas.drawCircle(
      Offset(
        size.width * 0.50,
        size.height * 0.69,
      ),
      size.width * 0.045,
      glyphPaint,
    );

    canvas.restore();
  }

  double _resolveScaleX() {
    if (impactProgress <= 0) {
      return 1.0;
    }

    if (impactProgress < 0.45) {
      return _lerp(
        1.0,
        1.10,
        impactProgress / 0.45,
      );
    }

    return _lerp(
      1.10,
      1.0,
      (impactProgress - 0.45) / 0.55,
    );
  }

  double _resolveScaleY() {
    if (impactProgress <= 0) {
      return 1.0;
    }

    if (impactProgress < 0.45) {
      return _lerp(
        1.0,
        0.90,
        impactProgress / 0.45,
      );
    }

    return _lerp(
      0.90,
      1.0,
      (impactProgress - 0.45) / 0.55,
    );
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
    covariant _ErrorIconPainter oldDelegate,
  ) {
    return oldDelegate.color != color ||
        oldDelegate.haloProgress != haloProgress ||
        oldDelegate.coreScale != coreScale ||
        oldDelegate.glyphProgress != glyphProgress ||
        oldDelegate.impactProgress != impactProgress;
  }
}