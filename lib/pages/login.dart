import 'package:flutter/material.dart';

import 'package:travel_planner/blocs/login_bloc.dart';
import 'package:travel_planner/resources/provider.dart';
import 'package:travel_planner/widgets/forms/email.dart';

class Login extends StatelessWidget {
  static final route = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[_createBG(context), _createForm(context)]),
    );
  }

  Widget _createBG(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final loginBloc = AppProvider.login(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(height: 150),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                    spreadRadius: 3,
                  ),
                ]),
            child: Column(children: [
              Text('Iniciar sesión', style: TextStyle(fontSize: 20)),
              SizedBox(height: 60),
              EmailInputStream(),
              SizedBox(height: 30),
              _createPassword(loginBloc),
              SizedBox(height: 30),
              _createButton(loginBloc)
            ]),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.pwdStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.error,
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Password'),
            onChanged: bloc.passwordChanged,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.canActivate,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text('Ingresar')),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed:
              snapshot.hasData ? () => _signUpAndNavigate(context, bloc) : null,
        );
      },
    );
  }

  _signUpAndNavigate(BuildContext context, LoginBloc bloc) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    await bloc.loginUser();

    if (bloc.userValue.email != null) {
      Navigator.pushReplacementNamed(context, 'home');
    }
  }
}
