import 'package:flutter/material.dart';

import '../resources/provider.dart';

class Home extends StatelessWidget {
  static final route = 'home';

  @override
  Widget build(BuildContext context) {
    final bloc = AppProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Planner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Gracias por registrarte mi perra: ${bloc.userValue}')
        ],
      ),
    );
  }
}
