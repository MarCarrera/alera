/// Defines the visual layout style of an animated app alert.
///
/// The style changes the composition of the dialog without affecting
/// the semantic alert type or its animation.
enum AleraStyle {
  /// Default layout.
  ///
  /// Header at the top with the animated icon positioned between
  /// the header and the content area.
  classic,

  /// Places the animated icon floating above the dialog.
  floatingTop,

  /// Places the animated icon as a badge near the top-left corner.
  cornerBadge,
}