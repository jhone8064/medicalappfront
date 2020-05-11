import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/Registrarcita_bloc.dart';
import 'Animation/FadeAnimation.dart';

class RegistrarCita extends StatelessWidget {
  final RegistrarCitaBloc _registrarCitaBloc = RegistrarCitaBloc();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(143, 148, 251, 2),
      appBar: new AppBar(
        title: Text('Pagina de registrar citas medicas'),
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
                              "Registrar citas",
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
                                      AssetImage('assets/images/regis2.png'))),
                        )),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          cedulaTextField(_registrarCitaBloc),
          SizedBox(height: 25.0),
          telefonoTextField(_registrarCitaBloc),
          SizedBox(height: 25.0),
          motivoTextField(_registrarCitaBloc),
          SizedBox(height: 25.0),
          registrarButton(_registrarCitaBloc, context),
          SizedBox(height: 15.0)          
        ],
      )
      )
      ),
      
    );
  }
}

Widget cedulaTextField(RegistrarCitaBloc bloc) => StreamBuilder<String>(
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

Widget telefonoTextField(RegistrarCitaBloc bloc) => StreamBuilder<String>(
      stream: bloc.telefono,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.number,
          onChanged: bloc.changeTelefono,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese su numero telefonico',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Telefono',
              prefixIcon: Icon(Icons.phone, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );

Widget motivoTextField(RegistrarCitaBloc bloc) => StreamBuilder<String>(
      stream: bloc.motivo,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.text,
          onChanged: bloc.changeMotivo,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese el motivo de la cita medica',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Motivo',
              prefixIcon: Icon(Icons.local_hospital, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );




Widget registrarButton(RegistrarCitaBloc bloc, BuildContext context) => StreamBuilder<bool>(
      stream: bloc.submitValid,
      builder: (context, snap) {
        return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => bloc.submit(context),
            child: Text(
              "Registrar cita",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );


