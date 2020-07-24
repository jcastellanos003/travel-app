import 'package:flutter/material.dart';

import '../blocs/blocs.dart';

class AppProvider extends InheritedWidget {
  static AppProvider _instance;

  factory AppProvider({Key key, Widget child}) {
    return _instance ??= new AppProvider._(key: key, child: child);
  }

  final loginBloc = LoginBloc();
  final mapBloc = MapBloc();

  AppProvider._({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc login(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>().loginBloc;
  }

  static MapBloc map(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>().mapBloc;
  }
}
