import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gitbub_clone/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Viewer',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.githubProfile,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
