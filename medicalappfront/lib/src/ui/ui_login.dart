import 'package:flutter/material.dart';
import 'package:medicalappfront/src/ui/ui_registrar.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicalappfront/src/blocs/bloc_login.dart';
import 'package:medicalappfront/src/providers/puch_notification_providers.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  LoginBloc bloc;
  PushNotificationProviders pushProvider;

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc();

    pushProvider = new PushNotificationProviders();
    pushProvider.initNotifications();

    pushProvider.mensajes.listen((event) {
      print('pushProvider ' + event);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Cita"),
              content: new Text(event),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        )),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.4,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        )),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/clock.png'))),
                        )),
                  ),
                  Positioned(
                    right: 167,
                    top: 300,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/logo4.png'))),
                        )),
                  ),
                  Positioned(
                    child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "MedicalApp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 25.0),
            usernameTextField(bloc),
            SizedBox(height: 25.0),
            passwordTextField(bloc),
            SizedBox(height: 25.0),
            submitButton(bloc, context, pushProvider),
            SizedBox(height: 15.0),
            cargarDatos(bloc),
            SizedBox(height: 15.0),
            registerButton(context)
          ],
        )),
      ),
    );
  }
}

Widget cargarDatos(LoginBloc bloc) => StreamBuilder<bool>(
      stream: bloc.loading,
      builder: (context, snap) {
        return Container(
          child:
              (snap.hasData && snap.data) ? CircularProgressIndicator() : null,
        );
      },
    );

Widget usernameTextField(LoginBloc bloc) => StreamBuilder<String>(
      stream: bloc.username,
      builder: (context, snap) {
        return TextField(
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeUsername,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'user@correo.com',
              prefixIcon: Icon(Icons.email, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              errorText: snap.error),
        );
      },
    );

Widget passwordTextField(LoginBloc bloc) => StreamBuilder<String>(
    stream: bloc.password,
    builder: (context, snap) {
      return TextField(
        obscureText: true,
        onChanged: bloc.changePassword,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(color: Colors.white)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            hintText: 'Password',
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.white,
            ),
            errorText: snap.error,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
      );
    });

Widget submitButton(LoginBloc bloc, BuildContext context,
        PushNotificationProviders pushProvider) =>
    StreamBuilder<bool>(
      stream: bloc.submitValid,
      builder: (context, snap) {
        bloc.setToken(pushProvider.tok);
        return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color.fromRGBO(143, 148, 251, 2),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => bloc.submit(context),
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );

Widget registerButton(BuildContext context) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Color.fromRGBO(143, 148, 251, 2),
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Registrar()));
      },
      child: Text(
        "Registrar",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
