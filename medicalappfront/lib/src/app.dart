import 'package:flutter/material.dart';
import 'package:medicalappfront/src/ui/ui_consultar.dart';
import 'ui/ui_login.dart';
import 'package:medicalappfront/src/blocs/authorization_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: logeoContenido(),
    );
  }

  logeoContenido() {
    return StreamBuilder<bool>(
        stream: authBloc.isSessionValid,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return HomeScreen();
          }
          return HomePage();
        });
  }
}
