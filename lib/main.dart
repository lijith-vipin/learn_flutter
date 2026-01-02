import 'package:flutter/material.dart';
import 'package:learn_flutter/router.dart';
import 'main_home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: appRoutes(
        isLoading: false,
        location: HomePage.routeName.appendToRootPath,
      ),
    );
  }
}
extension RouteNameExtension on String {
  /// Initial route must start from "/", appends root path "/" prior to the screen's route name
  String get appendToRootPath {
    return "/$this";
  }
}