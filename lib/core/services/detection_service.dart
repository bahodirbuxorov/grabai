import 'dart:convert';
import 'package:http/http.dart' as http;

class DetectionService {
  final String _baseUrl = 'http://10.30.11.44:1111/api/v1/det';

  Future<List<Map<String, dynamic>>> getDetections({int page = 1, int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl?page=$page&limit=$limit');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List detections = responseBody['det'] ?? [];
      return detections.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch detections. Code: ${response.statusCode}');
    }
  }


}
