import 'dart:math' as math;

import 'package:flutter/material.dart';

class WarningAnimatedIcon extends StatefulWidget {
  const WarningAnimatedIcon({
    super.key,
    required this.color,
    this.size = 72,
  });

  final Color color;
  final double size;

  @override
  State<WarningAnimatedIcon> createState() =>
      _WarningAnimatedIconState();
}

class _WarningAnimatedIconState
    extends State<WarningAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _haloProgress;
  late final Animation<double> _triangleScale;
  late final Animation<double> _glyphProgress;
  late final Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 850,
      ),
    );

    _haloProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.40,
        curve: Curves.easeOutCubic,
      ),
    );

    _triangleScale = Tween<double>(
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

    _glyphProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.38,
        0.72,
        curve: Curves.easeOutBack,
      ),
    );

    _pulseScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.045,
        ),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.045,
          end: 0.985,
        ),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.985,
          end: 1.0,
        ),
        weight: 30,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.70,
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
          painter: _WarningIconPainter(
            color: widget.color,
            haloProgress: _haloProgress.value,
            triangleScale: _triangleScale.value,
            glyphProgress: _glyphProgress.value,
            pulseScale: _pulseScale.value,
          ),
        );
      },
    );
  }
}

class _WarningIconPainter extends CustomPainter {
  const _WarningIconPainter({
    required this.color,
    required this.haloProgress,
    required this.triangleScale,
    required this.glyphProgress,
    required this.pulseScale,
  });

  final Color color;
  final double haloProgress;
  final double triangleScale;
  final double glyphProgress;
  final double pulseScale;

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
      triangleScale * pulseScale,
    );

    canvas.translate(
      -center.dx,
      -center.dy,
    );

    _drawTriangle(
      canvas,
      size,
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

    final radius = size.width * 0.46;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final haloPaint = Paint()
      ..color = color.withValues(
        alpha: 0.22 * haloProgress,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    final startAngle =
        (-math.pi * 0.85) +
        (haloProgress * math.pi * 0.35);

    final sweepAngle =
        math.pi *
        1.35 *
        haloProgress;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      haloPaint,
    );
  }

  void _drawTriangle(
    Canvas canvas,
    Size size,
  ) {
    final trianglePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(
        size.width * 0.50,
        size.height * 0.17,
      )
      ..lineTo(
        size.width * 0.84,
        size.height * 0.76,
      )
      ..quadraticBezierTo(
        size.width * 0.87,
        size.height * 0.82,
        size.width * 0.78,
        size.height * 0.82,
      )
      ..lineTo(
        size.width * 0.22,
        size.height * 0.82,
      )
      ..quadraticBezierTo(
        size.width * 0.13,
        size.height * 0.82,
        size.width * 0.16,
        size.height * 0.76,
      )
      ..close();

    canvas.drawPath(
      path,
      trianglePaint,
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
      -size.height * 0.14,
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
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final lineRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.465,
        size.height * 0.37,
        size.width * 0.07,
        size.height * 0.24,
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
        size.height * 0.68,
      ),
      size.width * 0.045,
      glyphPaint,
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
    covariant _WarningIconPainter oldDelegate,
  ) {
    return oldDelegate.color != color ||
        oldDelegate.haloProgress != haloProgress ||
        oldDelegate.triangleScale != triangleScale ||
        oldDelegate.glyphProgress != glyphProgress ||
        oldDelegate.pulseScale != pulseScale;
  }
}