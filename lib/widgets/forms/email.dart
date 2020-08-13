import 'package:flutter/material.dart';
import 'package:travel_planner/resources/state/state.dart';

class EmailInputStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _createEmail(StateProvider.getEmailStreamInstance());
  }

  Widget _createEmail(EmailStream email) {
    return StreamBuilder(
      stream: email.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                errorText: snapshot.error,
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'nombre@correo.com',
                labelText: 'Correo Electrónico'),
            onChanged: email.onChanged,
          ),
        );
      },
    );
  }
}
