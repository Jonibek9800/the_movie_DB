import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/models/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColor.mainBackground,),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppColor.mainBackground,
              selectedItemColor: Colors.deepPurple,
              unselectedItemColor: Colors.white),
          navigationDrawerTheme: const NavigationDrawerThemeData(backgroundColor: Colors.white, indicatorColor: Colors.white),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: Routes.pathRoutes(),
        initialRoute: "/");
  }
}
