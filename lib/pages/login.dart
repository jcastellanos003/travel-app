import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/blocs/login_bloc.dart';
import 'package:travel_planner/notifiers/change_notifier.dart';
import 'package:travel_planner/resources/provider.dart';
import 'package:travel_planner/widgets/widgets.dart';

class Login extends StatelessWidget {
  static final route = 'login';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = AppProvider.login(context);
    Widget main = Stack(children: <Widget>[
      _createBG(context),
      _createForm(context, loginBloc)
    ]);

    BuildContext dialogContext;

    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<GeneralChangeNotifier>(
        builder: (_, notifier, __) {
          if (notifier.state == NotifierState.initial) {
            return main;
          } else if (notifier.state == NotifierState.loading) {
            return CircularProgressIndicator();
          } else {
            return notifier.user.fold(
                (failure) => Text(failure.toString()), (user) => Text('ok'));
          }

          /*  if (notifier.state == NotifierState.loading) {
            WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  dialogContext = context;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }));
            return main;
          } else {
            return notifier.user.fold((failure) {
              if (dialogContext != null) {
                Navigator.pop(dialogContext, true);
              }
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _showMessage(failure.toString()));
              return main;
            }, (user) {
              Navigator.pushReplacementNamed(context, 'home');
              return Container();
            }); */

          /* if (notifier.failure != null) {
              if (dialogContext != null) {
                Navigator.pop(dialogContext, true);
              }
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _showMessage(notifier.failure.toString()));
            } else if (notifier.state == NotifierState.loaded) {
              Navigator.pushReplacementNamed(context, 'home');
            }
            return main; 
          }*/

          /*  if (notifier.state == NotifierState.initial) {
            return main;
          } else if (notifier.state == NotifierState.loading) {
            return CircularProgressIndicator();
          } else {
            if (notifier.failure != null) {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _showMessage(notifier.failure.toString()));
              return Text('Fail');
            } else {
              return Text('done');
            }
          } */
        },
      ),
    );

    /*  Scaffold(
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
        )); */
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

  Widget _createForm(BuildContext context, LoginBloc loginBloc) {
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
              PasswordInputStream(),
              SizedBox(height: 30),
              _createLoginButton(loginBloc),
              SizedBox(height: 30),
              RaisedButton(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: Text('Registrarme')),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 0,
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'registration'))
            ]),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  /* Widget _createPassword(LoginBloc bloc) {
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
                labelText: 'Contraseña'),
            onChanged: bloc.passwordChanged,
          ),
        );
      },
    );
  } */

  Widget _createLoginButton(LoginBloc bloc) {
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

  _showMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _signUpAndNavigate(BuildContext context, LoginBloc bloc) async {
    Provider.of<GeneralChangeNotifier>(context, listen: false)
        .login(bloc.emailState.value, bloc.passwordState.value);

    /* await bloc.loginUser();

    if (bloc.userValue != null && bloc.userValue.email != null) {
      Navigator.pushReplacementNamed(context, 'home');
    } */
  }
}
