import 'dart:math' as math;

import 'package:flutter/material.dart';

class LoadingAnimatedIcon extends StatefulWidget {
  const LoadingAnimatedIcon({
    super.key,
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<LoadingAnimatedIcon> createState() =>
      _LoadingAnimatedIconState();
}

class _LoadingAnimatedIconState
    extends State<LoadingAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _disableAnimations = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ??
        false;

    if (disableAnimations == _disableAnimations) {
      return;
    }

    _disableAnimations = disableAnimations;

    if (_disableAnimations) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



 @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LoadingSpinnerPainter(
              progress:
                  _disableAnimations
                      ? 0
                      : _controller.value,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _LoadingSpinnerPainter extends CustomPainter {
  const _LoadingSpinnerPainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  static const int _segments = 12;

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = size.center(
      Offset.zero,
    );

    final radius = size.shortestSide / 2;

    // Fondo blanco del icono.
    canvas.drawCircle(
      center,
      radius * 0.92,
      Paint()
        ..color = Colors.white,
    );

    // Contorno suave usando el color semántico/branding.
    canvas.drawCircle(
      center,
      radius * 0.90,
      Paint()
        ..color = color.withValues(
          alpha: 0.28,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.035,
    );

    final innerRadius =
        radius * 0.36;

    final outerRadius =
        radius * 0.68;

    final strokeWidth =
        size.width * 0.055;

    final activeIndex =
        (progress * _segments).floor();

    for (int index = 0;
        index < _segments;
        index++) {
      final angle =
          (-math.pi / 2) +
          (
            (math.pi * 2) /
            _segments *
            index
          );

      final distance =
          (activeIndex - index) %
          _segments;

      final opacity = switch (distance) {
        0 => 1.0,
        1 => 0.82,
        2 => 0.66,
        3 => 0.50,
        4 => 0.36,
        _ => 0.20,
      };

      final start = Offset(
        center.dx +
            math.cos(angle) *
                innerRadius,
        center.dy +
            math.sin(angle) *
                innerRadius,
      );

      final end = Offset(
        center.dx +
            math.cos(angle) *
                outerRadius,
        center.dy +
            math.sin(angle) *
                outerRadius,
      );

      final paint = Paint()
        ..color = color.withValues(
          alpha: opacity,
        )
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        start,
        end,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _LoadingSpinnerPainter oldDelegate,
  ) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}