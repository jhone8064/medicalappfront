import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

class PushNotificationProviders {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  String tok;

  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then(
          (token) => this.tok = token,
        );

    _firebaseMessaging.configure(
      onMessage: ( info ) {
        print('====onMessage==');
        print(info);
        _mensajesStreamController.sink.add(info['notification']['body']);
        return;
      },
      onLaunch: ( info ) {
        print('====onLaunch==');
        print(info);
        return;
      },

      onResume: ( info ) {
        print('====onResume==');
        print(info);
        return;
      },
      
      );
      
  }

  disponse(){
    _mensajesStreamController?.close();
  }
}
