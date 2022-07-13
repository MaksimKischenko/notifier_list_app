// ignore: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

import 'screens/screens.dart';

/// Simple static class to aggregate navigation
mixin Navigation {

  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void toHome() => navigatorKey.currentState?.pushNamed(
    HomeScreenOverView.pageRoute,
  );

  // static void toEdit() => navigatorKey.currentState?.pushNamed(
  //   ElementActionScreen.pageRoute,
  // );
}