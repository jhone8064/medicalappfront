import 'dart:convert';

import 'package:http/http.dart';
import 'package:medicalappfront/src/Constants.dart';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:flutter/foundation.dart';

class CitasProvider {
  Client client = Client();
  CitasList _citas;
  

  Future<CitasList> infoCitas(String id) async {   
    debugPrint("LLEGA 2 " + 'https://'+Constants.urlAuthority+'/consultarCitas?cedula='+id); 
    var res = await client.get('https://'+Constants.urlAuthority+'/consultarCitas?id='+id);  
   
    debugPrint(res.body);
    if (res.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      _citas = CitasList.fromJson(jsonDecode(res.body));
    } else {
      print(res.body);
    }
    return _citas;
  }
}
