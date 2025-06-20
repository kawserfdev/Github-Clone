import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gitbub_clone/models/repo_model.dart';
import 'package:gitbub_clone/models/user_model.dart';
import 'package:gitbub_clone/services/github_service.dart';
import 'package:gitbub_clone/utils/apis.dart';

final githubServiceProvider = Provider((ref) => GitHubService());

final usernameProvider = StateProvider<String>((ref) => APIs.userName);

final userProvider = FutureProvider<GitHubUser>((ref) async {
  final username = ref.watch(usernameProvider);
  final service = ref.read(githubServiceProvider);
  return service.fetchUser(username);
});

final repoListProvider = FutureProvider.family<List<GitHubRepo>, int>((
  ref,
  page,
) async {
  final username = ref.watch(usernameProvider);
  final service = ref.read(githubServiceProvider);
  return service.fetchRepos(username, page);
});
