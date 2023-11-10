import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/global_context_helper.dart';
import 'package:themoviedb/ui/navigator/main_navigator.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../movie_list/movie_list_model.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: GlobalContextHelper.state,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('ru', 'RU'), // Russian
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.mainBackground,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppColor.mainBackground,
              selectedItemColor: Colors.deepPurple,
              unselectedItemColor: Colors.white),
          navigationDrawerTheme: const NavigationDrawerThemeData(
              backgroundColor: Colors.white, indicatorColor: Colors.white),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: mainNavigation.routes,
        initialRoute: MainNavigationRouteNames.loaderWidget,
        onGenerateRoute: mainNavigation.onGenerateRoute,
      ),
    );
  }
}