import 'package:flutter/material.dart';

/// Defines the visual appearance of an animated app alert.
///
/// The theme controls the general appearance of the alert while keeping
/// the semantic alert type independent from the application's branding.
@immutable
class AleraTheme {
  /// Creates an alert theme.
  const AleraTheme({
    required this.primaryColor,
    this.stateColor,
    this.backgroundColor = Colors.white,
    this.titleColor = const Color(0xFF111827),
    this.messageColor = const Color(0xFF6B7280),
    this.borderRadius = 50.0, //24.0,
    this.contentPadding = 24.0,
    this.buttonHeight = 48.0,
  });

  /// Main branding color of the alert.
  ///
  /// This color should normally match the primary color of the
  /// application using the package.
  final Color primaryColor;

  /// Optional accent color associated with the semantic alert state.
  ///
  /// When `null`, the alert can resolve a default color depending
  /// on its [AleraType].
  final Color? stateColor;

  /// Background color of the dialog content.
  final Color backgroundColor;

  /// Color used for the alert title.
  final Color titleColor;

  /// Color used for the alert message.
  final Color messageColor;

  /// Corner radius of the alert dialog.
  final double borderRadius;

  /// General padding used inside the dialog content.
  final double contentPadding;

  /// Default height of the action buttons.
  final double buttonHeight;

  /// Creates a copy of this theme with the provided values replaced.
  AleraTheme copyWith({
    Color? primaryColor,
    Color? stateColor,
    bool clearStateColor = false,
    Color? backgroundColor,
    Color? titleColor,
    Color? messageColor,
    double? borderRadius,
    double? contentPadding,
    double? buttonHeight,
  }) {
    return AleraTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      stateColor: clearStateColor
          ? null
          : stateColor ?? this.stateColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      messageColor: messageColor ?? this.messageColor,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      buttonHeight: buttonHeight ?? this.buttonHeight,
    );
  }
}