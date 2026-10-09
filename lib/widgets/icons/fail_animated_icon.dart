import 'dart:math' as math;

import 'package:flutter/material.dart';

class FailAnimatedIcon extends StatefulWidget {
  const FailAnimatedIcon({
    super.key,
    required this.color,
    this.size = 72,
  });

  final Color color;
  final double size;

  @override
  State<FailAnimatedIcon> createState() =>
      _FailAnimatedIconState();
}

class _FailAnimatedIconState
    extends State<FailAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _haloProgress;
  late final Animation<double> _coreScale;
  late final Animation<double> _glyphProgress;
  late final Animation<double> _settleScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 820,
      ),
    );

    _haloProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.38,
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
          0.10,
          0.48,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    _glyphProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.32,
        0.72,
        curve: Curves.easeOutCubic,
      ),
    );

    _settleScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.96,
        ),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.96,
          end: 1.02,
        ),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.02,
          end: 1.0,
        ),
        weight: 25,
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
          painter: _FailIconPainter(
            color: widget.color,
            haloProgress: _haloProgress.value,
            coreScale: _coreScale.value,
            glyphProgress: _glyphProgress.value,
            settleScale: _settleScale.value,
          ),
        );
      },
    );
  }
}

class _FailIconPainter extends CustomPainter {
  const _FailIconPainter({
    required this.color,
    required this.haloProgress,
    required this.coreScale,
    required this.glyphProgress,
    required this.settleScale,
  });

  final Color color;
  final double haloProgress;
  final double coreScale;
  final double glyphProgress;
  final double settleScale;

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
      coreScale * settleScale,
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

    _drawCross(
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
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    final startAngle =
        (-math.pi * 0.20) -
        (haloProgress * math.pi * 0.35);

    final sweepAngle =
        math.pi *
        1.45 *
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

  void _drawCross(
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

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.085
      ..strokeCap = StrokeCap.round;

    final leftOffset = _lerp(
      -size.width * 0.18,
      0,
      progress,
    );

    final rightOffset = _lerp(
      size.width * 0.18,
      0,
      progress,
    );

    canvas.save();

    canvas.translate(
      leftOffset,
      0,
    );

    canvas.drawLine(
      Offset(
        size.width * 0.34,
        size.height * 0.34,
      ),
      Offset(
        size.width * 0.66,
        size.height * 0.66,
      ),
      paint,
    );

    canvas.restore();

    canvas.save();

    canvas.translate(
      rightOffset,
      0,
    );

    canvas.drawLine(
      Offset(
        size.width * 0.66,
        size.height * 0.34,
      ),
      Offset(
        size.width * 0.34,
        size.height * 0.66,
      ),
      paint,
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
    covariant _FailIconPainter oldDelegate,
  ) {
    return oldDelegate.color != color ||
        oldDelegate.haloProgress != haloProgress ||
        oldDelegate.coreScale != coreScale ||
        oldDelegate.glyphProgress != glyphProgress ||
        oldDelegate.settleScale != settleScale;
  }
}