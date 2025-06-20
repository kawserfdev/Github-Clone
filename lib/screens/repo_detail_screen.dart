import 'package:flutter/material.dart';
import 'package:gitbub_clone/models/repo_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailScreen extends StatelessWidget {
  final GitHubRepo repo;
  const RepoDetailScreen({super.key, required this.repo});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repo.description ?? 'No description',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(' Stars: ${repo.stargazersCount}'),
            if (repo.language != null) Text(' Language: ${repo.language}'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _launchURL(repo.htmlUrl),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in Browser'),
            ),
          ],
        ),
      ),
    );
  }
}
