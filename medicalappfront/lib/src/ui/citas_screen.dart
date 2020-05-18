import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/citas_bloc.dart';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:table_calendar/table_calendar.dart';


class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  CalendarController _controller;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    CitasBloc bloc = CitasBloc();
    bloc.getInfoCitas();
    return Scaffold(
      backgroundColor: Color.fromRGBO(143, 148, 251, 2),
      appBar: AppBar(
        title: Text('Consulta de citas'),
      ),
      
      body: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(calendarController: _controller)
          ],
          
        )
      ),
      
    );

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
            labelText: snapshot.data.lstCitas[index].fecha.toString(),
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