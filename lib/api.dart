import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static Future<Map<String, dynamic>> getHargaCabai() async {
final response = await http.get(Uri.parse('https://siskaperbapo.jatimprov.go.id/'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Gagal mendapatkan data harga cabai');
    }
  }
}
