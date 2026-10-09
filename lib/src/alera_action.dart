import 'dart:async';

import 'package:flutter/foundation.dart';

/// Defines an action that can be displayed inside an app alert.
///
/// An alert can contain zero, one, or multiple actions depending on
/// the configuration of the dialog.
@immutable
class AleraAction {
  /// Creates an alert action.
  const AleraAction({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
    this.autoClose = true,
  });

  /// Text displayed inside the action button.
  final String label;

  /// Callback executed when the action is pressed.
  ///
  /// It supports both synchronous and asynchronous callbacks.
  final FutureOr<void> Function() onPressed;

  /// Indicates whether this action should use the primary visual style.
  ///
  /// Typically, the main action of the alert should set this to `true`.
  final bool isPrimary;

  /// Determines whether the alert should close automatically
  /// after this action is executed.
  ///
  /// Defaults to `true`.
  final bool autoClose;
}