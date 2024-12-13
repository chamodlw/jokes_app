import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchJokes() async {
  final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_ten'));
  if (response.statusCode == 200) {
    final List<dynamic> jokes = json.decode(response.body);
    return jokes.map((joke) => "${joke['setup']} ${joke['punchline']}").toList();
  } else {
    throw Exception('Failed to load jokes');
  }
}
