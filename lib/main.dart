import 'package:flutter/material.dart';

import './resources/provider.dart';
import './pages/pages.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  // This widget is the root of your application.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = AppProvider.login(context);
    Widget main = AppProvider(
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
          Registration.route: (BuildContext context) => Registration()
        }));

    return Scaffold(
        key: _scaffoldKey,
        body: StreamBuilder(
          stream: loginBloc.errorStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _showMessage(snapshot.data));
              return main;
            }
            return main;
          },
        ));
  }

  _showMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
