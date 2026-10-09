import 'package:alera/alera.dart';
import 'package:alera/widgets/icons/error_animated_icon.dart';
import 'package:alera/widgets/icons/fail_animated_icon.dart';
import 'package:alera/widgets/icons/info_animated_icon.dart';
import 'package:alera/widgets/icons/loading_animated_icon.dart';
import 'package:alera/widgets/icons/warning_animated_icon.dart';
import 'package:flutter/material.dart';
import 'icons/success_animated_icon.dart';

/// Displays the semantic icon of an alert with an animation
/// appropriate for its type.
///
/// The icon color can be customized independently from the
/// application's primary branding color.
class AleraAnimatedIcon extends StatelessWidget {
  const AleraAnimatedIcon({
    super.key,
    required this.type,
    required this.color,
    this.size = 72.0,
  });

  /// Semantic type of the alert.
  final AleraType type;

  /// Color applied to the icon.
  final Color color;

  /// Size of the icon.
  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: switch (type) {
        AleraType.success => SuccessAnimatedIcon(
            color: color,
            size: size,
          ),
      
        AleraType.warning => WarningAnimatedIcon(
            color: color,
            size: size,
          ),
        
      
        AleraType.error => ErrorAnimatedIcon(
          color: color,
          size: size,
        ),
      
        AleraType.fail => FailAnimatedIcon(
          color: color,
          size: size,
        ),
      
        AleraType.info => InfoAnimatedIcon(
          color: color,
          size: size,
        ),
        AleraType.loading => LoadingAnimatedIcon(
          color: color,
          size: size,
        ),
      },
    );
  }
}