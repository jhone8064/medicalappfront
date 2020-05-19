import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/citas_bloc.dart';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:medicalappfront/src/ui/Animation/FadeAnimation.dart';
import 'package:table_calendar/table_calendar.dart';


class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  
  @override
  void initState() {
    
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    _events = {
      DateTime.now(): ['Event A0', 'Event B0', 'Event C0'],
      DateTime.now(): ['Event A1'],};
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
                          margin: EdgeInsets.only(top: 30),
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
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                todayColor: Colors.orangeAccent,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white
                )
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white
                ),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events){
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events)=>
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(10.0)
                    ),
                  
                  child: Text(date.day.toString(), style: TextStyle(
                    color: Colors.white
                  ),)
                ),
                todayDayBuilder: (context, date, events)=>
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10.0)
                    ),
                  
                  child: Text(date.day.toString(), style: TextStyle(
                    color: Colors.white
                  ),)
                ),
              ),
              calendarController: _controller,
              ),
              ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                  
                )),
          ],
          
        ),
        
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