/// Defines the semantic type of an animated app alert.
///
/// The alert type describes the meaning of the alert, but it does not
/// determine the application's primary color.
///
/// Visual properties such as colors, icons, and animations can be
/// customized independently.
enum AleraType {
  /// Indicates that an operation completed successfully.
  success,

  /// Indicates that the user should pay attention to something.
  warning,

  /// Indicates that a technical or unexpected error occurred.
  error,

  /// Indicates that an operation completed with a negative result.
  ///
  /// Example:
  /// A request was processed correctly but was rejected.
  fail,

  /// Displays general or informative content.
  info,
  loading,

}