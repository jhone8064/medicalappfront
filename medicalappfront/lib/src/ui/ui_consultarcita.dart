import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicalappfront/src/blocs/Consulta_bloc.dart';
import 'package:medicalappfront/src/models/model_regis.dart';

import 'Animation/FadeAnimation.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Consultas();
}

class Consultas extends State<HomeScreen> {
  static ConsultaBloc bloc = ConsultaBloc();

  @override
  initState() {
    super.initState();
    bloc.getInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    bloc.getInfoUser();
    return Scaffold(
      backgroundColor: Color.fromRGBO(143, 148, 251, 2),
      appBar: new AppBar(
        title: Text('Pagina de consulta'),
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Consultar citas",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          cedulaTextField(bloc),
          SizedBox(height: 25.0),
          nombresTextField(bloc),
          SizedBox(height: 25.0),
          apellidosTextField(bloc),
          SizedBox(height: 25.0),
          usernameTextField(bloc),
          SizedBox(height: 25.0)
          
        ],
      ))),
    );
  }
}

Widget cedulaTextField(ConsultaBloc bloc) => StreamBuilder<UserRegisData>(
      stream: bloc.infoUser,
      builder: (context, snap) {
        return TextField(
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: snap.data.cedula,
            prefixIcon: Icon(Icons.perm_identity),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            errorText: snap.error,
            alignLabelWithHint: true,
          ),
        );
      },
    );

Widget nombresTextField(ConsultaBloc bloc) => StreamBuilder<UserRegisData>(
      stream: bloc.infoUser,
      builder: (context, snap) {
        return TextField(
          readOnly: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: snap.data.nombres,              
              prefixIcon: Icon(Icons.supervised_user_circle),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              errorText: snap.error),
        );
      },
    );

Widget apellidosTextField(ConsultaBloc bloc) => StreamBuilder<UserRegisData>(
      stream: bloc.infoUser,
      builder: (context, snap) {
        return TextField(
          readOnly: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: snap.data.apellidos,              
              prefixIcon: Icon(Icons.supervised_user_circle),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              errorText: snap.error),
        );
      },
    );

Widget usernameTextField(ConsultaBloc bloc) => StreamBuilder<UserRegisData>(
      stream: bloc.infoUser,
      builder: (context, snap) {
        return TextField(
          readOnly: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: snap.data.username,              
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              errorText: snap.error),
        );
      },
    );



