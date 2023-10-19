
import 'package:flutter/cupertino.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';

import '../widgets/singUp/sing_up.dart';

class Routes {
  static Map<String, WidgetBuilder> pathRoutes() {
    return {
      "/": (context) => const AuthWidget(),
      "/main_screen": (context) => const MainScreenWidget(),
      "/main_screen/movie_details": (context) {
        int movieId = ModalRoute.of(context)!.settings.arguments as int;
        return MovieDetailsWidget(movieId: movieId,);},
      "/sign_up": (context) => const SingUp(),
    };
  }
}
