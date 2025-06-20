import 'dart:convert';
import 'package:gitbub_clone/models/repo_model.dart';
import 'package:gitbub_clone/models/user_model.dart';
import 'package:gitbub_clone/utils/apis.dart';
import 'package:http/http.dart' as http;

class GitHubService {
  Future<GitHubUser> fetchUser(String username) async {
    final response = await http.get(Uri.parse(APIs.user(username)));
    if (response.statusCode == 200) {
      return GitHubUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<GitHubRepo>> fetchRepos(String username, int page) async {
    final response = await http.get(Uri.parse(
      APIs.repo(username, page),
    ));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => GitHubRepo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
