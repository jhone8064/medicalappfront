import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SalirScreen extends StatefulWidget {
  @override 
SalirScreen _salir = SalirScreen();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
    
static Future<void> pop({bool animated}) async {
  await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
  
  
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
       
      ),
     
          floatingActionButton: new FloatingActionButton(
            onPressed: ()=> exit(0),
            tooltip: 'Close app',
            child: new Icon(Icons.close),
          ), 
    );
  }



}
}