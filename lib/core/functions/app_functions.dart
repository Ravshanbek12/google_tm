import 'package:flutter/material.dart';

Route fade(Widget child) {
  return PageRouteBuilder(
    transitionsBuilder: (_, animation, __, constantChild) {
      return constantChild;
    },
    pageBuilder: (_, __, ___) => child,
  );
}
