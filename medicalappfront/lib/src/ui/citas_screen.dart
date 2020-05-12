import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/citas_bloc.dart';
import 'package:medicalappfront/src/models/citasList.dart';


class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CitasBloc bloc = CitasBloc();
    

    bloc.getInfoCitas();

    return Scaffold(
      body: StreamBuilder(
        stream: bloc.infoCitas,
        builder: (context, AsyncSnapshot<CitasList> snapshot) {
          if (snapshot.hasData) {
           return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<CitasList> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.lstCitas.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return TextField(
          readOnly: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.white)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: snapshot.data.lstCitas[index].fecha,
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.perm_identity, color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),
            ),           
            alignLabelWithHint: true,
          ),
        );
        }
        );
  }
}
