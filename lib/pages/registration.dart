import 'package:flutter/material.dart';
import 'package:travel_planner/blocs/registration_bloc.dart';
import 'package:travel_planner/resources/provider.dart';
import 'package:travel_planner/widgets/widgets.dart';

class Registration extends StatelessWidget {
  static final route = 'registration';

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
    final registrationBloc = AppProvider.registration(context);
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
              Text('Registrarse', style: TextStyle(fontSize: 20)),
              SizedBox(height: 60),
              _createName(registrationBloc),
              SizedBox(height: 30),
              EmailInputStream(),
              SizedBox(height: 30),
              _createButton(registrationBloc)
            ]),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _createName(RegistrationBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                errorText: snapshot.error,
                icon: Icon(Icons.text_fields, color: Colors.deepPurple),
                hintText: 'My name',
                labelText: 'Name'),
            onChanged: bloc.nameChanged,
          ),
        );
      },
    );
  }

  Widget _createButton(RegistrationBloc bloc) {
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

  _signUpAndNavigate(BuildContext context, RegistrationBloc bloc) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    await bloc.registerUser();

    /*  if (bloc.userValue.email != null) {
      Navigator.pushReplacementNamed(context, 'code');
    } 
    


    ValueNotifier<bool> loading = ValueNotifier(bloc.loading);
    print(loading);

    ValueListenableBuilder(
      builder: (BuildContext context, bool value, Widget child) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      valueListenable: loading,
      child: Text('expensive child'),
    );

    
    */
  }
}
