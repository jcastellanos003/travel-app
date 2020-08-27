import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './resources/provider.dart';
import './pages/pages.dart';
import 'package:travel_planner/notifiers/change_notifier.dart';

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
          Login.route: (BuildContext context) => ChangeNotifierProvider(
              create: (_) => GeneralChangeNotifier(), child: Login()),
          Home.route: (BuildContext context) => Home(),
          Map.route: (BuildContext context) => Map(),
          Registration.route: (BuildContext context) => Registration()
        }));
  }
}
