import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PersonService {
  final String _baseUrl = 'http://10.30.11.44:1111/api/v1/';

  Future<bool> createPerson({
    required String name,
    required int age,
    required String gender,
    required File? imageFile,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
    request.fields['name'] = name;
    request.fields['age'] = age.toString();
    request.fields['gender'] = gender;

    if (imageFile != null) {
      final fileStream = await http.MultipartFile.fromPath('img', imageFile.path);
      request.files.add(fileStream);
    }

    final response = await request.send();
    return response.statusCode == 200;
  }

  Future<List<Map<String, dynamic>>> getPersons() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load persons');
    }
  }

  Future<Map<String, dynamic>?> getPersonById(int personId) async {
    final response = await http.get(Uri.parse('http://10.30.11.44:1111/api/v1/'));
    if (response.statusCode == 200) {
      final List persons = jsonDecode(response.body);
      return persons.cast<Map<String, dynamic>>().firstWhere(
            (p) => p['id'] == personId,
        orElse: () => {},
      );
    } else {
      throw Exception('Failed to load persons');
    }
  }
}
