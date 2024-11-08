import 'package:http/http.dart' as http;
import 'package:chat/models/usuario.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/global/environment.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      // Verifica la respuesta del servidor
      print('Respuesta del servidor: ${resp.body}');

      if (resp.statusCode == 200) {
        final usuariosResponse = usuariosResponseFromJson(resp.body);
        // Imprime los usuarios obtenidos para ver qué datos traen
        print('Usuarios obtenidos: ${usuariosResponse.usuarios}');
        return usuariosResponse.usuarios;
      } else {
        print('Error en la respuesta del servidor: ${resp.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error al obtener los usuarios: $e');
      return [];
    }
  }
}
