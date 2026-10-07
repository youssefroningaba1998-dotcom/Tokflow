import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  final bool firebaseReady;

  const AppState({
    super.key,
    required this.firebaseReady,
    required super.child,
  });

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>()!;
  }

  @override
  bool updateShouldNotify(AppState oldWidget) =>
      firebaseReady != oldWidget.firebaseReady;
}
