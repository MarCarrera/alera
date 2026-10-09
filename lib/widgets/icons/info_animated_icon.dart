import 'dart:math' as math;

import 'package:flutter/material.dart';

class InfoAnimatedIcon extends StatefulWidget {
  const InfoAnimatedIcon({
    super.key,
    required this.color,
    this.size = 72,
  });

  final Color color;
  final double size;

  @override
  State<InfoAnimatedIcon> createState() =>
      _InfoAnimatedIconState();
}

class _InfoAnimatedIconState
    extends State<InfoAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _haloProgress;
  late final Animation<double> _coreScale;
  late final Animation<double> _dotProgress;
  late final Animation<double> _stemProgress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 780,
      ),
    );

    _haloProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.45,
        curve: Curves.easeOutCubic,
      ),
    );

    _coreScale = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.12,
          0.50,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    _dotProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.34,
        0.64,
        curve: Curves.easeOutBack,
      ),
    );

    _stemProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.48,
        0.88,
        curve: Curves.easeOutCubic,
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
          painter: _InfoIconPainter(
            color: widget.color,
            haloProgress: _haloProgress.value,
            coreScale: _coreScale.value,
            dotProgress: _dotProgress.value,
            stemProgress: _stemProgress.value,
          ),
        );
      },
    );
  }
}

class _InfoIconPainter extends CustomPainter {
  const _InfoIconPainter({
    required this.color,
    required this.haloProgress,
    required this.coreScale,
    required this.dotProgress,
    required this.stemProgress,
  });

  final Color color;
  final double haloProgress;
  final double coreScale;
  final double dotProgress;
  final double stemProgress;

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

    canvas.scale(coreScale);

    canvas.translate(
      -center.dx,
      -center.dy,
    );

    _drawCore(
      canvas,
      size,
      center,
    );

    _drawInfoGlyph(
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
        alpha: 0.16 * haloProgress,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.035
      ..strokeCap = StrokeCap.round;

    final startAngle =
        (-math.pi / 2) +
        (haloProgress * math.pi * 0.12);

    final sweepAngle =
        math.pi *
        1.75 *
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

  void _drawInfoGlyph(
    Canvas canvas,
    Size size,
    Offset center,
  ) {
    final glyphPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    if (dotProgress > 0) {
      final dotScale = _lerp(
        0.3,
        1.0,
        dotProgress,
      );

      canvas.save();

      final dotCenter = Offset(
        size.width * 0.50,
        size.height * 0.37,
      );

      canvas.translate(
        dotCenter.dx,
        dotCenter.dy,
      );

      canvas.scale(dotScale);

      canvas.drawCircle(
        Offset.zero,
        size.width * 0.045,
        glyphPaint,
      );

      canvas.restore();
    }

    if (stemProgress > 0) {
      final progress = stemProgress.clamp(
        0.0,
        1.0,
      );

      final translateY = _lerp(
        size.height * 0.14,
        0,
        progress,
      );

      final stemHeight = size.height * 0.25;

      canvas.save();

      canvas.translate(
        0,
        translateY,
      );

      final stemRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.465,
          size.height * 0.47,
          size.width * 0.07,
          stemHeight,
        ),
        Radius.circular(
          size.width * 0.035,
        ),
      );

      canvas.drawRRect(
        stemRect,
        glyphPaint,
      );

      canvas.restore();
    }
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
    covariant _InfoIconPainter oldDelegate,
  ) {
    return oldDelegate.color != color ||
        oldDelegate.haloProgress != haloProgress ||
        oldDelegate.coreScale != coreScale ||
        oldDelegate.dotProgress != dotProgress ||
        oldDelegate.stemProgress != stemProgress;
  }
}