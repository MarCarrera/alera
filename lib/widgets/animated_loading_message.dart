import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedLoadingMessage extends StatefulWidget {
  const AnimatedLoadingMessage({
    super.key,
    required this.message,
    required this.color,
    this.fontSize = 14,
  });

  final String message;
  final Color color;
  final double fontSize;

  @override
  State<AnimatedLoadingMessage> createState() =>
      _AnimatedLoadingMessageState();
}

class _AnimatedLoadingMessageState
    extends State<AnimatedLoadingMessage> {
  Timer? _timer;

  int _dotCount = 0;

  bool _disableAnimations = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ??
        false;

    if (disableAnimations == _disableAnimations &&
        (_timer != null || disableAnimations)) {
      return;
    }

    _disableAnimations = disableAnimations;

    _timer?.cancel();
    _timer = null;

    if (_disableAnimations) {
      // Reduced motion:
      // mostramos el estado completo sin animarlo.
      _dotCount = 3;
      return;
    }

    _dotCount = 0;

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(
        milliseconds: 450,
      ),
      (_) {
        if (!mounted) return;

        setState(() {
          _dotCount = (_dotCount + 1) % 4;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w400,
      height: 1.45,
      color: widget.color,
    );

    final dots = '.' * _dotCount;

    return Semantics(
      label: widget.message,
      child: ExcludeSemantics(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Invisible.
            // Reserva siempre el espacio máximo.
            Opacity(
              opacity: 0,
              child: Text(
                '${widget.message}...',
                style: style,
              ),
            ),

            // Texto visible.
            Text(
              '${widget.message}$dots',
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}