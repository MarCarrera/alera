import 'package:alera/alera.dart';
import 'package:alera/widgets/animated_alert_icon.dart';
import 'package:flutter/material.dart';
import 'package:alera/widgets/animated_loading_message.dart';


class AleraDialog extends StatelessWidget {
  const AleraDialog({
    super.key,
    required this.type,
    required this.style,
    required this.title,
    required this.message,
    required this.theme,
    this.actions = const [],
  });

  final AleraType type;
  final AleraStyle style;
  final String title;
  final String message;
  final AleraTheme theme;
  final List<AleraAction> actions;

  @override
  Widget build(BuildContext context) {
    final stateColor =
    theme.stateColor ??
    (type == AleraType.loading
        ? theme.primaryColor
        : _resolveStateColor(type));
    final screenSize = MediaQuery.sizeOf(context);

    final dialogWidth = screenSize.width < 360
        ? screenSize.width - 24
        : screenSize.width < 420
            ? screenSize.width - 32
            : 380.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: screenSize.width < 360 ? 12 : 20,
        vertical: 24,
      ),
      child: SizedBox(
        width: dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenSize.height * 0.85,
          ),
          child: Semantics(
              container: true,
              scopesRoute: true,
              namesRoute: true,
              explicitChildNodes: true,
              label: title,
            child: _buildLayout(
              context,
              stateColor,
            ),
          ),
        ),
      ),
    );
  }

Widget _buildCornerBadgeLayout(
  BuildContext context,
  Color stateColor,
) {
  const iconSize = 72.0;
  const iconPadding = 7.0;

  return Stack(
    clipBehavior: Clip.none,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 24,
        ),
        child: ClipRRect(
          borderRadius: _dialogBorderRadius(),
          child: Material(
            color: theme.backgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCornerHeader(),

                Flexible(
                  child: SingleChildScrollView(
                    child: _buildCornerContent(
                      context,
                    ),
                  ),
                ),

                if (actions.length == 1)
                  _buildSingleAction(
                    context,
                    actions.first,
                  ),

                if (actions.length == 2)
                  _buildDoubleActions(
                    context,
                    actions[0],
                    actions[1],
                  ),
              ],
            ),
          ),
        ),
      ),

      Positioned(
        top: 0,
        left: -14,
        child: Container(
          padding: const EdgeInsets.all(
            iconPadding,
          ),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            shape: BoxShape.circle,
          ),
          child: AleraAnimatedIcon(
            type: type,
            color: stateColor,
            size: iconSize,
          ),
        ),
      ),
    ],
  );
}

Widget _buildCornerHeader() {
  return Container(
    width: double.infinity,
    height: 64,
    color: theme.primaryColor,
  );
}

Widget _buildCornerContent(
  BuildContext context,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      theme.contentPadding,
      20,
      theme.contentPadding,
      actions.isEmpty
          ? theme.contentPadding
          : 18,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title.trim().isNotEmpty)
        Semantics(
           header: true,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.titleColor,
              height: 1.2,
            ),
          ),
        ),
        if (title.trim().isNotEmpty && message.trim().isNotEmpty)
        const SizedBox(height: 10),
        
        if (message.trim().isNotEmpty)
         _buildMessage(),
      ],
    ),
  );
}

BorderRadius _dialogBorderRadius() {
  return switch (style) {
    AleraStyle.cornerBadge => const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(60),
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(8),
      ),

    _ => BorderRadius.circular(
        theme.borderRadius,
      ),
  };
}

Widget _buildMessage() {
  if (message.trim().isEmpty) {
    return const SizedBox.shrink();
  }

  if (type == AleraType.loading) {
    return AnimatedLoadingMessage(
      message: message,
      color: theme.messageColor,
    );
  }

  return Text(
    message,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 14,
      height: 1.45,
      color: theme.messageColor,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget _buildFloatingTopLayout(
  BuildContext context,
  Color stateColor,
) {
  const iconSize = 72.0;
  const iconPadding = 7.0;

  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.topCenter,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 42,
        ),
        child: ClipRRect(
          borderRadius: _dialogBorderRadius(),
          child: Material(
            color: theme.backgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFloatingHeader(),

                Flexible(
                  child: SingleChildScrollView(
                    child: _buildFloatingContent(
                      context,
                    ),
                  ),
                ),

                if (actions.length == 1)
                  _buildSingleAction(
                    context,
                    actions.first,
                  ),

                if (actions.length == 2)
                  _buildDoubleActions(
                    context,
                    actions[0],
                    actions[1],
                  ),
              ],
            ),
          ),
        ),
      ),

      Positioned(
        top: 0,
        child: Container(
          padding: const EdgeInsets.all(
            iconPadding,
          ),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            shape: BoxShape.circle,
          ),
          child: AleraAnimatedIcon(
            type: type,
            color: stateColor,
            size: iconSize,
          ),
        ),
      ),
    ],
  );
}

Widget _buildFloatingHeader() {
  return Container(
    width: double.infinity,
    height: 50,
    color: theme.primaryColor,
  );
}

Widget _buildFloatingContent(
  BuildContext context,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      theme.contentPadding,
      32,
      theme.contentPadding,
      actions.isEmpty
          ? theme.contentPadding
          : 18,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title.trim().isNotEmpty)
        Semantics(
           header: true,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.titleColor,
              height: 1.2,
            ),
          ),
        ),
         if (title.trim().isNotEmpty && message.trim().isNotEmpty)
        const SizedBox(height: 10),
         if (message.trim().isNotEmpty)
         _buildMessage(),
      ],
    ),
  );
}

Widget _buildClassicLayout(
  BuildContext context,
  Color stateColor,
) {
  return ClipRRect(
    borderRadius:_dialogBorderRadius(),
    child: Material(
      color: theme.backgroundColor,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),

              Flexible(
                child: SingleChildScrollView(
                  child: _buildContent(
                    context,
                    stateColor,
                  ),
                ),
              ),

              if (actions.length == 1)
                _buildSingleAction(
                  context,
                  actions.first,
                ),

              if (actions.length == 2)
                _buildDoubleActions(
                  context,
                  actions[0],
                  actions[1],
                ),
            ],
          ),

          Positioned(
            top: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: AleraAnimatedIcon(
                type: type,
                color: stateColor,
                size: 72,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildLayout(
  BuildContext context,
  Color stateColor,
) {
  return switch (style) {
    AleraStyle.classic =>
      _buildClassicLayout(
        context,
        stateColor,
      ),

    AleraStyle.floatingTop =>
      _buildFloatingTopLayout(
        context,
        stateColor,
      ),

    AleraStyle.cornerBadge =>
      _buildCornerBadgeLayout(
        context,
        stateColor,
      ),
  };
}

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 75,
      color: theme.primaryColor,
    );
  }

Widget _buildContent(
  BuildContext context,
  Color stateColor,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      theme.contentPadding,
      48,
      theme.contentPadding,
      actions.isEmpty ? theme.contentPadding : 18,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title.trim().isNotEmpty)
        Semantics(
           header: true,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.titleColor,
              height: 1.2,
            ),
          ),
        ),
         if (title.trim().isNotEmpty && message.trim().isNotEmpty)
        const SizedBox(height: 8),
         if (message.trim().isNotEmpty)
         _buildMessage(),
      ],
    ),
  );
}

BorderRadius _singleActionBorderRadius() {
  return switch (style) {
    AleraStyle.cornerBadge => const BorderRadius.only(
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(8),
      ),

    _ => BorderRadius.only(
        bottomLeft: Radius.circular(theme.borderRadius),
        bottomRight: Radius.circular(theme.borderRadius),
      ),
  };
}

Widget _buildSingleAction(
  BuildContext context,
  AleraAction action,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      10,
      0,
      10,
      10,
    ),
    child: SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: () async {
          await action.onPressed();

          if (action.autoClose && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        style: FilledButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: _singleActionBorderRadius(),
          ),
        ),
        child: Text(
          action.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

Widget _buildDoubleActions(
  BuildContext context,
  AleraAction firstAction,
  AleraAction secondAction,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      8,
      0,
      8,
      8,
    ),
    child: SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            child: _buildActionByPriority(
              context,
              firstAction,
              isLeft: true,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: _buildActionByPriority(
              context,
              secondAction,
              isLeft: false,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildActionByPriority(
  BuildContext context,
  AleraAction action, {
  required bool isLeft,
}) {
  if (action.isPrimary) {
    return _buildPrimaryAction(
      context,
      action,
      isLeft: isLeft,
    );
  }

  return _buildSecondaryAction(
    context,
    action,
    isLeft: isLeft,
  );
}

Widget _buildPrimaryAction(
  BuildContext context,
  AleraAction action, {
  required bool isLeft,
}) {
  return SizedBox.expand(
    child: FilledButton(
      onPressed: () async {
        await action.onPressed();

        if (action.autoClose && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      style: FilledButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: isLeft
                ? _leftBottomRadius()
                : Radius.zero,
            bottomRight: !isLeft
                ? _rightBottomRadius()
                : Radius.zero,
          ),
        ),
      ),
      child: Text(
        action.label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Radius _leftBottomRadius() {
  return switch (style) {
    AleraStyle.cornerBadge => const Radius.circular(60),
    _ => Radius.circular(theme.borderRadius),
  };
}

Radius _rightBottomRadius() {
  return switch (style) {
    AleraStyle.cornerBadge => const Radius.circular(8),
    _ => Radius.circular(theme.borderRadius),
  };
}

Widget _buildSecondaryAction(
  BuildContext context,
  AleraAction action, {
  required bool isLeft,
}) {
  return SizedBox.expand(
    child: OutlinedButton(
      onPressed: () async {
        await action.onPressed();

        if (action.autoClose && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: theme.primaryColor,
        backgroundColor: theme.backgroundColor,
        padding: EdgeInsets.zero,
        side: BorderSide(
          color: theme.primaryColor,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: isLeft
                ? _leftBottomRadius()
                : Radius.zero,
            bottomRight: !isLeft
                ? _rightBottomRadius()
                : Radius.zero,
          ),
        ),
      ),
      child: Text(
        action.label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}



  Color _resolveStateColor(AleraType type) {
  return switch (type) {
    AleraType.success => const Color(0xFF22C55E),
    AleraType.warning => const Color(0xFFF59E0B),
    AleraType.error => const Color.fromARGB(255, 245, 65, 65),
    AleraType.fail => const Color(0xFFBE123C),
    AleraType.info => const Color(0xFF3B82F6),
    AleraType.loading => const Color.fromARGB(255, 115, 115, 121),
  };
}
}