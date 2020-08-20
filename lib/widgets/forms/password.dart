import 'package:flutter/material.dart';
import 'package:travel_planner/resources/state/state.dart';

class PasswordInputStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _createPassword(StateProvider.getPasswordStreamInstance());
  }

  Widget _createPassword(PasswordStream password) {
    return StreamBuilder(
      stream: password.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.error,
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña'),
            onChanged: password.onChanged,
          ),
        );
      },
    );
  }
}
