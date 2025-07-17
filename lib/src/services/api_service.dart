import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  /**
   * USAR API LOCAL
   * http://10.0.2.2:3000
   */
  final _baseUrl = "http://10.0.2.2:3000";

  Future<String?> login(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 30)); // Timeout opcional (remova se quiser sem limite)

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['token'];
      } else {
        print('Erro no login: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exceção durante login: $e');
      return null;
    }
  }
}