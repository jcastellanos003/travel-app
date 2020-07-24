import 'package:flutter/material.dart';

import './resources/provider.dart';
import './widgets/widgets.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppProvider(
        child: MaterialApp(
            title: 'Travel Planner',
            theme: ThemeData(
              primarySwatch: Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: Login.route,
            routes: {
          Login.route: (BuildContext context) => Login(),
          Home.route: (BuildContext context) => Home(),
          Map.route: (BuildContext context) => Map(),
        }));
  }
}
