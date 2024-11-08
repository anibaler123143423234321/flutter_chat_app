import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';
class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    try {
      final resp = await http.get(
          Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken(),
          });

      // Verifica la respuesta del servidor
      print('Respuesta del servidor: ${resp.body}');

      if (resp.statusCode == 200) {
        final mensajesResp = mensajesResponseFromJson(resp.body);

        // Imprime los mensajes obtenidos para ver qué datos traen
        print('Mensajes obtenidos: ${mensajesResp.mensajes}');
        return mensajesResp.mensajes;
      } else {
        // Imprime el código de estado si la respuesta no es exitosa
        print('Error en la respuesta del servidor: ${resp.statusCode}');
        return [];
      }
    } catch (e) {
      // Imprime el error si ocurre una excepción
      print('Error al obtener los mensajes: $e');
      return [];
    }
  }
}

