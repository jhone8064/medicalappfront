import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/Registrarcita_bloc.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class RegistrarCita extends StatefulWidget {
  @override
  _RegistrarCita createState() => _RegistrarCita();
}

class _RegistrarCita extends State<RegistrarCita> {
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
            height: 200,
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
                        margin: EdgeInsets.only(top: 100),
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
                                image: AssetImage('assets/images/regis2.png'))),
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
          fechaTextField(_registrarCitaBloc),
          SizedBox(height: 25.0),                   
          registrarButton(_registrarCitaBloc, context),
          SizedBox(height: 15.0)
        ],
      ))),
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese su Cedula',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Cedula',
              prefixIcon: Icon(Icons.perm_identity, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              errorText: snap.error),
        );
      },
    );

Widget telefonoTextField(RegistrarCitaBloc bloc) => StreamBuilder<String>(
      stream: bloc.numero,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.number,
          onChanged: bloc.changeNumero,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese su numero telefonico',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Telefono',
              prefixIcon: Icon(Icons.phone, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese el motivo de la cita medica',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Motivo',
              prefixIcon: Icon(Icons.local_hospital, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              errorText: snap.error),
        );
      },
    );

var textController = new TextEditingController();

Widget fechaTextField(RegistrarCitaBloc bloc) => StreamBuilder<String>(           
      builder: (context, snap) {
        return TextField(    
          onTap: (){_selectDate(context, bloc);},
          readOnly: true,
          controller: textController,                
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese la fecha de la cita',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Fecha',
              prefixIcon: Icon(Icons.date_range, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );

/*Widget fechaHora(RegistrarCitaBloc bloc) => StreamBuilder<String>(
    stream: bloc.fecha,
    builder: (context, snap) {
      return RaisedButton(
        onPressed: () => _selectDate(context, bloc),
        child: Text('Seleccione fecha'),
      );
    });*/

DateTime firstDate = DateTime.now();
final df = new DateFormat('dd-MM-yyyy hh:mm a');
Future<Null> _selectDate(BuildContext context, RegistrarCitaBloc bloc) async {
  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: bloc.fechaHora,
      firstDate: firstDate,
      lastDate: DateTime(2101),
      cancelText: "Cancelar",
      builder: (context, child) {
        return Theme(
          data: ThemeData(
              primaryColor: Colors.orangeAccent,
              disabledColor: Colors.brown,
              accentColor: Colors.yellow),
          child: child,
        );
      });
  if (picked != null && picked != bloc.fechaHora) bloc.fechaHora = picked;  
  _selectHora(context, bloc);
}

Future<Null> _selectHora(BuildContext context, RegistrarCitaBloc bloc) async {
  final timePicked = await showRoundedTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),    
  );    
  bloc.fechaHora =  new DateTime(bloc.fechaHora.year, bloc.fechaHora.month, bloc.fechaHora.day, timePicked.hour, timePicked.minute, 0, 0, 0);
  textController.text = df.format(bloc.fechaHora);
}

/* Widget horaTextField(RegistrarCitaBloc bloc) => StreamBuilder<String>(
      stream: bloc.hora,
      builder: (context, snap) {
        return TextField(
          keyboardType: TextInputType.text,
          onChanged: bloc.changeHora,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: 'Ingrese la hora de la cita medica',
              labelStyle: TextStyle(color: Colors.white),
              hintText: 'Hora',
              prefixIcon: Icon(Icons.hourglass_empty, color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              errorText: snap.error),
        );
      },
    );*/

Widget registrarButton(RegistrarCitaBloc bloc, BuildContext context) =>
    StreamBuilder<bool>(
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
