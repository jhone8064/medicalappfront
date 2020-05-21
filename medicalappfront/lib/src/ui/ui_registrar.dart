import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/Registrar_bloc.dart';
import 'Animation/FadeAnimation.dart';

class Registrar extends StatelessWidget {
  final RegistrarBloc _registrarBloc= RegistrarBloc();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: Text('Pagina de registrar paciente'),
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
                              "Registrar paciente",
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
                    top: 10,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/logo3.png'))),
                        )),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          cedulaTextField(_registrarBloc),
          SizedBox(height: 25.0),
          nombresTextField(_registrarBloc),
          SizedBox(height: 25.0),
          apellidosTextField(_registrarBloc),
          SizedBox(height: 25.0),
          usernameTextField(_registrarBloc),
          SizedBox(height: 25.0),
          passwordTextField(_registrarBloc),
          SizedBox(height: 15.0),
          registrarButton(_registrarBloc, context),
          SizedBox(height: 15.0)          
        ],
      )
      )
      ),
      
    );
  }
}

Widget cedulaTextField(RegistrarBloc bloc) => StreamBuilder<String>(
      stream: bloc.cedula,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.number,
          onChanged: bloc.changeCedula,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese su Cedula',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Cedula',
              prefixIcon: Icon(Icons.perm_identity, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );

Widget nombresTextField(RegistrarBloc bloc) => StreamBuilder<String>(
      stream: bloc.nombres,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.text,
          onChanged: bloc.changeNombre,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese sus Nombres',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Nombres',
              prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );

Widget apellidosTextField(RegistrarBloc bloc) => StreamBuilder<String>(
      stream: bloc.apellidos,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.text,
          onChanged: bloc.changeApellidos,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese sus Apellidos',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Apellidos',
              prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );

Widget usernameTextField(RegistrarBloc bloc) => StreamBuilder<String>(
      stream: bloc.username,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeUsername,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'user@correo.com',
              prefixIcon: Icon(Icons.email, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );

Widget passwordTextField(RegistrarBloc bloc) => StreamBuilder<String>(
    stream: bloc.password,
    builder: (context, snap) {
      return TextField(
        obscureText: true,
        onChanged: bloc.changePassword,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            hintText: 'Password',
            prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
            errorText: snap.error,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)))
                ),
      );
    });

Widget registrarButton(RegistrarBloc bloc, BuildContext context) => StreamBuilder<bool>(
      stream: bloc.submitValid,
      builder: (context, snap) {
        return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color.fromRGBO(143, 148, 251, 2),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => bloc.submit(context),
            child: Text(
              "Registrar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
