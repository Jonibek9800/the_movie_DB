import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_trailers/movie_trailer_widget.dart';

import '../../widgets/auth/auth_model.dart';
import '../../widgets/auth/auth_widget.dart';
import '../../widgets/main_screen/main_screen_widget.dart';
import '../../widgets/movie_details/movie_details_widget.dart';
import '../../widgets/singUp/sing_up.dart';

abstract class MainNavigationRouteNames {
  static const auth = "auth";
  static const mainScreen = "/";
  static const movieDetails = "/movie_details";
  static const movieTrailer = "/movie_details/trailer";
  static const signUp = "/sign_up";
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) => MultiProvider(providers: [
          ChangeNotifierProvider<AuthViewModel>.value(value: AuthViewModel())
        ], child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
    MainNavigationRouteNames.signUp: (context) => const SingUp(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (context) => MultiProvider(providers: [
                  ChangeNotifierProvider<MovieDetailsViewModel>.value(
                      value: MovieDetailsViewModel(movieId: movieId))
                ], child: const MovieDetailsWidget()));
      case MainNavigationRouteNames.movieTrailer:
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
            builder: (context) =>  MovieTrailerWidget(youTubeKey: youTubeKey));
      default:
        const widget = Text("navigation error!!!");
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
