import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/citas_bloc.dart';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:medicalappfront/src/ui/Animation/FadeAnimation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medicalappfront/src/models/model_regiscita.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  CalendarController _controller;
  Map<DateTime, List<UserRegisCita>> _events;
  List<UserRegisCita> _selectedEvents;
  CitasBloc bloc = CitasBloc();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<UserRegisCita>> _groupEvents(
      List<UserRegisCita> allEvents) {
    Map<DateTime, List<UserRegisCita>> data = {};
    allEvents.forEach((event) {
      DateTime date =
          DateTime(event.fecha.year, event.fecha.month, event.fecha.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    bloc.getInfoCitas();
    return Scaffold(
      backgroundColor: Color.fromRGBO(143, 148, 251, 2),
      appBar: AppBar(
        title: Text('Consulta de citas'),
      ),
      body: StreamBuilder<CitasList>(
          stream: bloc.infoCitas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserRegisCita> allEvents = snapshot.data.lstCitas;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              } else {
                _events = {};
                _selectedEvents = [];
              }
            }
            return SingleChildScrollView(
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
                        canEventMarkersOverflow: true,
                        todayColor: Colors.orangeAccent,
                        selectedColor: Theme.of(context).primaryColor,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  ..._selectedEvents.map((event) => ListTile(
                        title: Text(event.fecha.toString()),
                      )),
                ],
              ),
            );
          }),
    );
  }

  Widget buildList(List<UserRegisCita> snapshot) {
    return GridView.builder(
        itemCount: snapshot.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return TextField(
            readOnly: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              labelText: snapshot[index].fecha.toString(),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.perm_identity, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              alignLabelWithHint: true,
            ),
          );
        });
  }
}
