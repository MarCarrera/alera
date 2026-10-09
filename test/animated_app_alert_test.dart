import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alera/alera.dart';

void main() {
  test('AleraType exposes expected values', () {
    expect(
      AleraType.values,
      containsAll([
        AleraType.success,
        AleraType.warning,
        AleraType.error,
        AleraType.fail,
        AleraType.info,
      ]),
    );
  });

  test('AleraTheme can be created', () {
    const theme = AleraTheme(
      primaryColor: Colors.blue,
    );

    expect(theme.primaryColor, Colors.blue);
    expect(theme.backgroundColor, Colors.white);
  });
}