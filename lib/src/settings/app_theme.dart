import 'package:flutter/material.dart';

const appColor = Color(0xFFe8c23a);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: appColor,
  fontFamily: 'Zen Kaku Gothic Antique',
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: appColor,
  fontFamily: 'Zen Kaku Gothic Antique',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
);