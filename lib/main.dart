import 'package:flutter/material.dart';
import 'package:github_api/repo.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo Viewer',
      home: RepoListScreen(),
    );
  }
}

class RepoListScreen extends StatefulWidget {
  @override
  _RepoListScreenState createState() => _RepoListScreenState();
}

class _RepoListScreenState extends State<RepoListScreen> {
  final GitHubService _gitHubService = GitHubService();
  List<Map<String, dynamic>> _repositories = [];

  @override
  void initState() {
    super.initState();
    _loadRepositories();
  }

  Future<void> _loadRepositories() async {
    try {
      final repositories = await _gitHubService.fetchRepositories('YOUR_GITHUB_USERNAME');
      setState(() {
        _repositories = repositories;
      });
    } catch (e) {
      print('Error loading repositories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repositories'),
      ),
      body: _repositories.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _repositories.length,
        itemBuilder: (context, index) {
          final repo = _repositories[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                repo['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                repo['description'] ?? 'No description available',
              ),
            ),
          );
        },
      ),
    );
  }
}
