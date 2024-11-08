import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    this._socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    this._socket.onConnect((_) {
      print('Conectado al servidor');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      print('Desconectado del servidor');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();

      // Emitir evento para limpiar la lista de usuarios
      _socket.emit('lista-usuarios', []);
    });

    this._socket.onConnectError((error) {
      print('Error de conexión: $error');
    });

    this._socket.on('lista-usuarios', (data) {
      print('Usuarios actualizados: $data');
    });
  }

  void disconnect() {
    this._socket.disconnect();
    print('Desconectado manualmente');
  }
}
