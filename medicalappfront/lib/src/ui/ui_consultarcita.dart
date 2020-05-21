import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicalappfront/src/blocs/Consulta_bloc.dart';
import 'package:medicalappfront/src/models/model_regis.dart';

import 'Animation/FadeAnimation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _Consultas createState() => _Consultas();
}

class _Consultas extends State<HomeScreen> {
  ConsultaBloc bloc = ConsultaBloc();

  @override
  void initState() {
    super.initState();
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
                            "Consultar Paciente",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                ),
                Positioned(
                  right: 167,
                  top: 2,
                  width: 80,
                  height: 150,
                  child: FadeAnimation(
                      1.5,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/buscar2.png'))),
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
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.white)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: snap.data.cedula,
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.perm_identity, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: snap.data.nombres,
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon:
                  Icon(Icons.supervised_user_circle, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: snap.data.apellidos,
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon:
                  Icon(Icons.supervised_user_circle, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: snap.data.username,
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              errorText: snap.error),
        );
      },
    );
