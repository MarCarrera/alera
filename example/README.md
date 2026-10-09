# Alera

**Beautiful animated alerts for Flutter.**

Alera is a customizable Flutter alert library featuring animated icons, multiple visual styles, configurable transitions, and a dedicated loading experience.

## Features

- **Six alert types:** success, warning, error, fail, info, and loading.
- **Three visual styles:** classic, floating top, and corner badge.
- **Ten transitions:** adaptive, fade scale, top, bottom, left, right, center reveal, forward, tilt in, and none.
- **Animated icons:** distinctive animations for semantic alert types.
- **Customizable appearance:** configure colors and themes to match your application.
- **Flexible actions:** support for up to two actions on standard alerts.
- **Dedicated loading alerts:** animated spinner, animated loading message, and support for one optional action.
- **Programmatic dismissal:** close loading alerts through `AleraController`.
- **Responsive layouts:** designed for mobile and tablet screens.
- **Accessibility considerations:** semantic support and reduced-motion handling.

## Installation

Add Alera to your Flutter project:

```bash
flutter pub add alera
```

Import the package:

```dart
import 'package:alera/alera.dart';
```

## Quick start

Display a success alert:

```dart
Alera.show(
  context,
  type: AleraType.success,
  title: 'Success',
  message: 'Your changes have been saved.',
);
```

Display an error alert:

```dart
Alera.show(
  context,
  type: AleraType.error,
  title: 'Something went wrong',
  message: 'Unable to complete the operation.',
);
```

## Alert types

Alera provides six semantic alert types:

| Type | Intended use |
|---|---|
| `AleraType.success` | Successful operations |
| `AleraType.warning` | Warnings and situations requiring attention |
| `AleraType.error` | Errors and unsuccessful operations |
| `AleraType.fail` | Failed or rejected operations |
| `AleraType.info` | Informational messages |
| `AleraType.loading` | Operations in progress |

## Visual styles

Choose the visual appearance using `AleraStyle`:

```dart
AleraStyle.classic
AleraStyle.floatingTop
AleraStyle.cornerBadge
```

Example:

```dart
Alera.show(
  context,
  type: AleraType.success,
  title: 'Completed',
  message: 'The record was saved successfully.',
  style: AleraStyle.cornerBadge,
);
```

If no style is specified, Alera uses `AleraStyle.classic`.

## Transitions

Customize the alert entrance and exit animation with `AleraTransition`:

```dart
AleraTransition.adaptive
AleraTransition.fadeScale
AleraTransition.top
AleraTransition.bottom
AleraTransition.left
AleraTransition.right
AleraTransition.centerReveal
AleraTransition.forward
AleraTransition.tiltIn
AleraTransition.none
```

Example:

```dart
Alera.show(
  context,
  type: AleraType.info,
  title: 'Information',
  message: 'Your session is active.',
  transition: AleraTransition.forward,
);
```

The default transition is `AleraTransition.adaptive`, which selects a transition based on the chosen visual style.

## Actions

Standard alerts support up to two actions.

```dart
Alera.show(
  context,
  type: AleraType.warning,
  title: 'Delete record?',
  message: 'This action may not be reversible.',
  actions: [
    AleraAction(
      label: 'Cancel',
      onPressed: () {},
    ),
    AleraAction(
      label: 'Delete',
      onPressed: () {
        // Perform the deletion.
      },
    ),
  ],
);
```

For available action options, consult the `AleraAction` API.

## Loading alerts

Alera provides a dedicated loading alert for asynchronous operations. It features an animated spinner and a loading message.

```dart
final loading = Alera.showLoading(
  context,
  title: 'Loading',
  message: 'Loading record',
);
```

Close the alert when the operation finishes:

```dart
loading.close();
```

For a complete asynchronous workflow, use `try` and `finally` to ensure the alert closes even if the operation fails:

```dart
final loading = Alera.showLoading(
  context,
  title: 'Loading',
  message: 'Loading record',
);

try {
  await loadRecord();
} finally {
  loading.close();
}
```

Replace `loadRecord()` with your application's asynchronous operation.

Loading alerts support zero or one action, making it possible to provide an optional cancellation action.

## Customization

Alera supports customization through parameters such as `primaryColor`, `stateColor`, and `theme`.

For example:

```dart
Alera.show(
  context,
  type: AleraType.info,
  title: 'Information',
  message: 'This alert uses a custom primary color.',
  primaryColor: const Color(0xFF3F64AD),
);
```

Use `AleraTheme` when you need to configure the appearance through a reusable theme. Refer to the API documentation for the available theme properties.

## Examples

The package includes an `example/` application demonstrating Alera's alert types, styles, transitions, and loading behavior.

## License

See the `LICENSE` file in this repository.