import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:medicalappfront/src/ui/ui_consultarcita.dart';
import 'package:medicalappfront/src/ui/ui_registrarcita.dart';





class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  

  //enrutamiento a las paginas

  final RegistrarCita _listRegistrarCita = RegistrarCita();
  final HomeScreen _listConsultarCita = HomeScreen();

  Widget _showPage = new RegistrarCita();

  


  Widget _pageChooser(int page){
    switch(page){
      case 0:
      return _listRegistrarCita;
      break;
      case 1:
      return _listConsultarCita;
      break;
      //case 2:
      //return;
      //break;
      default:
      return new Container(
        child: new Center(
          child: new Text('No escogio ninguna pagina.', style: new TextStyle(fontSize: 30),),
          
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        bottomNavigationBar: CurvedNavigationBar(
         // initialIndex: pageIndex,
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.exit_to_app, size: 30),
           
          ],
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Color.fromRGBO(143, 148, 251, 2),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Color.fromRGBO(143, 148, 251, 2),
          child: Center(
            child: _showPage,
            //child: Column(
              //children: <Widget>[
                //Text(pageIndex.toString(), textScaleFactor: 10.0),
                //RaisedButton(
                  //child: Text('Go To Page of index 1'),
                  //onPressed: () {
                   // final CurvedNavigationBarState navBarState =
                     //   _bottomNavigationKey.currentState;
                    //navBarState.setPage(1);
                  //},
               // )
              //],
            //),
          ),
        ));
  }
}