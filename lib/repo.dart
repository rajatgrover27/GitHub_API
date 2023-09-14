import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String _baseUrl = 'https://api.github.com';

  Future<List<Map<String, dynamic>>> fetchRepositories(String username) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/freeCodeCamp/repos'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
