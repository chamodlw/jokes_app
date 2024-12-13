import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/cache_helper.dart';

class JokesScreen extends StatefulWidget {
  @override
  _JokesScreenState createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  late Future<List<String>> jokes;

  @override
  void initState() {
    super.initState();
    jokes = fetchAndCacheJokes();
  }

  Future<List<String>> fetchAndCacheJokes() async {
    try {
      final jokes = await fetchJokes();
      await cacheJokes(jokes);
      return jokes;
    } catch (_) {
      return getCachedJokes();
    }
  }

  void refreshJokes() {
    setState(() {
      jokes = fetchAndCacheJokes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.ac_unit),
        centerTitle: true,
        title: Text(
          'Jokes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFFD369),
        foregroundColor: Color(0xFF333333),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshJokes,
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load jokes'));
          } else {
            return Container(
              color: Color(0xFFFFF9E8),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.mood, color: Color(0xFF333333)),
                    tileColor: Color(0xFFFFE4B5),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    title: Text(snapshot.data![index]),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
