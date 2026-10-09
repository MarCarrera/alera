import 'package:alera/alera.dart';
import 'package:alera/src/alera_dialog.dart';
import 'package:flutter/material.dart';


/// Public API used to display animated app alerts.
class Alera {
  const Alera._();  

  static Future<T?> show<T>(
  BuildContext context, {
  required AleraType type,
  required String title,
  required String message,
  AleraStyle style = AleraStyle.classic,
  AleraTransition transition =
      AleraTransition.adaptive,
  Color? primaryColor,
  Color? stateColor,
  AleraTheme? theme,
  List<AleraAction> actions = const [],
  bool barrierDismissible = true,
}) {
  return _show<T>(
    context,
    type: type,
    title: title,
    message: message,
    style: style,
    transition: transition,
    primaryColor: primaryColor,
    stateColor: stateColor,
    theme: theme,
    actions: actions,
    barrierDismissible: barrierDismissible,
  );
}
static AleraController showLoading(
  BuildContext context, {
  required String title,
  required String message,
  AleraStyle style = AleraStyle.classic,
  AleraTransition transition =
      AleraTransition.adaptive,
  Color? primaryColor,
  Color? stateColor,
  AleraTheme? theme,
  AleraAction? action,
  bool barrierDismissible = false,
}) {
  final controller =
      AleraController._();

  final actions =
      action == null
          ? const <AleraAction>[]
          : <AleraAction>[
              action,
            ];

  _show<void>(
    context,
    type: AleraType.loading,
    title: title,
    message: message,
    style: style,
    transition: transition,
    primaryColor: primaryColor,
    stateColor: stateColor,
    theme: theme,
    actions: actions,
    barrierDismissible:
        barrierDismissible,
    controller: controller,
  ).whenComplete(
    controller._markClosed,
  );

  return controller;
}
static Future<T?> _show<T>(
  BuildContext context, {
  required AleraType type,
  required String title,
  required String message,
  required AleraStyle style,
  required AleraTransition transition,
  Color? primaryColor,
  Color? stateColor,
  AleraTheme? theme,
  List<AleraAction> actions = const [],
  bool barrierDismissible = true,
  AleraController? controller,
}) {
  assert(
    actions.length <= 2,
    'Animated App Alert currently supports a maximum of 2 actions.',
  );

  assert(
    type != AleraType.loading ||
        actions.length <= 1,
    'Loading alerts support a maximum of 1 action.',
  );

  final resolvedTheme =
      theme ??
      AleraTheme(
        primaryColor:
            primaryColor ??
            Theme.of(context).colorScheme.primary,
        stateColor: stateColor,
      );

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel:
        MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration:
        const Duration(milliseconds: 260),

    pageBuilder: (
      dialogContext,
      animation,
      secondaryAnimation,
    ) {
      if (controller != null) {
        final route =
            ModalRoute.of(dialogContext);

        if (route != null) {
          controller._attachRoute(route);
        }
      }

      return AleraDialog(
        type: type,
        style: style,
        title: title,
        message: message,
        theme: resolvedTheme,
        actions: actions,
      );
    },

    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final resolvedTransition =
          _resolveTransition(
        style,
        transition,
      );

      return _buildTransition(
        context,
        animation,
        child,
        resolvedTransition,
      );
    },
  );
}



  static AleraTransition _resolveTransition(
    AleraStyle style,
    AleraTransition transition,
  ) {
    if (transition != AleraTransition.adaptive) {
      return transition;
    }

    return switch (style) {
      AleraStyle.classic => AleraTransition.fadeScale,

      AleraStyle.floatingTop => AleraTransition.top,

      AleraStyle.cornerBadge => AleraTransition.left,
    };
  }

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Widget child,
    AleraTransition transition,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return switch (transition) {
      AleraTransition.fadeScale => FadeTransition(
        opacity: curvedAnimation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1.0).animate(curvedAnimation),
          child: child,
        ),
      ),

      AleraTransition.top => FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.08),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      ),

      AleraTransition.bottom => FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      ),

      AleraTransition.left => FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.08, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      ),

      AleraTransition.right => FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      ),

      AleraTransition.tiltIn =>
  AnimatedBuilder(
    animation: curvedAnimation,
    child: child,
    builder: (context, child) {
      final scale = Tween<double>(
        begin: 0.92,
        end: 1.0,
      ).evaluate(curvedAnimation);

      final angle = Tween<double>(
        begin: -0.15,
        end: 0.0,
      ).evaluate(curvedAnimation);

      final offset = Tween<double>(
        begin: 10,
        end: 0,
      ).evaluate(curvedAnimation);

      return Opacity(
        opacity: curvedAnimation.value,
        child: Transform.translate(
          offset: Offset(0, offset),
          child: Transform.rotate(
            angle: angle,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
        ),
      );
    },
  ),

      AleraTransition.forward => AnimatedBuilder(
        animation: curvedAnimation,
        child: child,
        builder: (context, child) {
          final scale = Tween<double>(
            begin: 0.88,
            end: 1.0,
          ).evaluate(curvedAnimation);

          final offset = Tween<double>(
            begin: 8.0,
            end: 0.0,
          ).evaluate(curvedAnimation);

          return Opacity(
            opacity: curvedAnimation.value,
            child: Transform.translate(
              offset: Offset(0, offset),
              child: Transform.scale(scale: scale, child: child),
            ),
          );
        },
      ),

      AleraTransition.none => child,

      AleraTransition.adaptive => child,
    };
  }
}
class AleraController {
  AleraController._();

  VoidCallback? _closeCallback;

  bool _closed = false;

  /// Indicates whether the alert has already been
  /// closed or a close operation has been requested.
  bool get isClosed => _closed;

  /// Closes the alert associated with this controller.
  void close() {
    if (_closed) return;

    _closed = true;

    _closeCallback?.call();
  }

  void _attachRoute(
    Route<dynamic> route,
  ) {
    _closeCallback = () {
      final navigator = route.navigator;

      if (navigator == null ||
          !route.isActive) {
        return;
      }

      if (route.isCurrent) {
        navigator.pop();
      } else {
        navigator.removeRoute(route);
      }
    };

    // Permite llamar close() incluso antes de que
    // el diálogo haya terminado de construirse.
    if (_closed) {
      _closeCallback?.call();
    }
  }

  void _markClosed() {
    _closed = true;
    _closeCallback = null;
  }
}
