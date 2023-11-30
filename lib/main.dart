// Importa el paquete http
import 'dart:convert';
import 'package:http/http.dart' as http;

class VacunacionAPI {
  // Hacer _baseUrl final ya que no se reasigna
  static final String _baseUrl = 'https://yourserver.com/vacunacion';

  static Future<void> insertarVacunacion({
    required String numeroServicio,
    required String nombreCliente,
    required String nombreEspecie,
    required double valorVacuna,
    required int cantidadVacunas,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/insertar');
      var response = await http.post(
        url,
        body: jsonEncode({
          'numeroServicio': numeroServicio,
          'nombreCliente': nombreCliente,
          'nombreEspecie': nombreEspecie,
          'valorVacuna': valorVacuna,
          'cantidadVacunas': cantidadVacunas,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Vacunacion insertada correctamente');
      } else {
        print('Error al insertar vacunacion: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> modificarVacunacion({
    required String numeroServicio,
    required String nombreCliente,
    required String nombreEspecie,
    required double valorVacuna,
    required int cantidadVacunas,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/modificar');
      var response = await http.put(
        url,
        body: jsonEncode({
          'numeroServicio': numeroServicio,
          'nombreCliente': nombreCliente,
          'nombreEspecie': nombreEspecie,
          'valorVacuna': valorVacuna,
          'cantidadVacunas': cantidadVacunas,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Vacunacion modificada correctamente');
      } else {
        print('Error al modificar vacunacion: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> eliminarVacunacion({required String numeroServicio}) async {
    try {
      var url = Uri.parse('$_baseUrl/eliminar/$numeroServicio');
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        print('Vacunacion eliminada correctamente');
      } else {
        print('Error al eliminar vacunacion: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<List<dynamic>> listarVacunacionesPorEspecie(
      {required String nombreEspecie}) async {
    try {
      var url = Uri.parse('$_baseUrl/listarPorEspecie/$nombreEspecie');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> vacunaciones = jsonDecode(response.body);
        return vacunaciones;
      } else {
        print('Error al listar vacunaciones: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
