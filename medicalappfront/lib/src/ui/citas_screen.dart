import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalappfront/src/blocs/citas_bloc.dart';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:medicalappfront/src/ui/Animation/FadeAnimation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medicalappfront/src/models/model_regiscita.dart';
import 'package:intl/intl.dart';
import 'package:medicalappfront/src/providers/puch_notification_providers.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  CalendarController _controller;
  Map<DateTime, List<UserRegisCita>> _events;
  List<UserRegisCita> _selectedEvents;
  CitasBloc bloc = CitasBloc();
  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];

    final pushProvider = new PushNotificationProviders();
    pushProvider.initNotifications();

    pushProvider.mensajes.listen((event) {
      print('pushProvider ' + event);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Cita"),
              content: new Text(event),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        },
      );
    });
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
                        print(events.length);
                        if (events.length == 0) {
                          _selectedEvents = [];
                        } else {
                          _selectedEvents = events;
                        }
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
                  ..._selectedEvents.map((event) => Container(
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            border: Border.all(width: 0.8),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(6, 6),
                                blurRadius: 3,
                              )
                            ]),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          title: Text(df.format(event.fecha).toString() +
                              '    ' +
                              event.strEstado()),
                          enabled: event.isEnable(),
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context1) {
                              return AlertDialog(
                                title: new Text("Cita"),
                                content: new Text('Movito: ' +
                                    event.motivo +
                                    '\n' +
                                    'Fecha: ' +
                                    df.format(event.fecha).toString() +
                                    '\n' +
                                    'Estado: ' +
                                    event.strEstado()),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Cerrar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  new FlatButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    child: new Text("Cancelar Cita"),
                                    onPressed: () {
                                      bloc.cancelarCita(context, event);                                      
                                      bloc.getInfoCitas();
                                    },
                                  )
                                ],
                              );
                            },
                          ),
                        ),
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
