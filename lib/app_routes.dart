import 'package:flutter/material.dart';
import 'package:gitbub_clone/models/repo_model.dart';
import 'package:gitbub_clone/screens/profile_screen.dart';
import 'package:gitbub_clone/screens/repo_detail_screen.dart';
import 'package:gitbub_clone/screens/repos_screen.dart';

class AppRoutes {
  static const String githubProfile = '/';
  static const String repositories = '/repositories';
  static const String repoDetail = '/repoDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case githubProfile:
        return MaterialPageRoute(builder: (_) => const GitHubProfileScreen());
      case repositories:
      return MaterialPageRoute(builder: (_) => const RepositoriesScreen());
      case repoDetail:
        final repo = settings.arguments as GitHubRepo;
        return MaterialPageRoute(builder: (_) => RepoDetailScreen(repo: repo));

      default:
        return _errorRoute('Page not found');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(child: Text(message)),
        );
      },
    );
  }
}
