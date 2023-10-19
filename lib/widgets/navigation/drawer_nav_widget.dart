import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';

class MovieMenuBar {
  const MovieMenuBar(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

class MovieMenuBarTwo {
  const MovieMenuBarTwo(
    this.lable,
    this.icon,
  );

  final String lable;
  final Widget icon;
}

class DrawerNavWidget extends StatefulWidget {
  const DrawerNavWidget({super.key});

  @override
  State<DrawerNavWidget> createState() => _DrawerNavWidgetState();
}

class _DrawerNavWidgetState extends State<DrawerNavWidget> {
  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    screenIndex = selectedScreen;
    setState(() {});
  }

  List<MovieMenuBar> movieMenu = const <MovieMenuBar>[
    MovieMenuBar(
        'Фильмы',
        Icon(
          Icons.movie_creation_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.movie,
          color: AppColor.textColor,
        )),
    MovieMenuBar(
        'Сериалы',
        Icon(
          Icons.local_movies_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.local_movies,
          color: AppColor.textColor,
        )),
    MovieMenuBar(
        'Люди',
        Icon(
          Icons.people_alt_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.people,
          color: AppColor.textColor,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: AppColor.mainBackground,
      onDestinationSelected: handleScreenChanged,
      selectedIndex: screenIndex,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Menu',
              style: TextStyle(fontSize: 16, color: AppColor.textColor)),
        ),
        ...movieMenu.map(
          (MovieMenuBar movieMenu) {
            return NavigationDrawerDestination(
              label: Text(
                movieMenu.label,
                style: const TextStyle(color: AppColor.textColor),
              ),
              icon: movieMenu.icon,
              selectedIcon: movieMenu.selectedIcon,
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(),
        ),
        ...movieMenuTwo.map(
          (MovieMenuBarTwo movieMenuBarTwo) {
            return NavigationDrawerDestination(
                icon: movieMenuBarTwo.icon,
                label: Text(
                  movieMenuBarTwo.lable,
                  style: const TextStyle(color: AppColor.textColor),
                ));
          },
        ),
      ],
    );
  }
}

List<MovieMenuBarTwo> movieMenuTwo = const <MovieMenuBarTwo>[
  MovieMenuBarTwo(
      "Книга редакторов",
      Icon(
        Icons.book_rounded,
        size: 20,
        color: AppColor.textColor,
      )),
  MovieMenuBarTwo(
      "Обсуждение",
      Icon(
        Icons.description_outlined,
        size: 20,
        color: AppColor.textColor,
      )),
  MovieMenuBarTwo(
      "Доска почетов",
      Icon(
        Icons.calendar_today_rounded,
        size: 20,
        color: AppColor.textColor,
      )),
  MovieMenuBarTwo(
      "API",
      Icon(
        Icons.api,
        size: 20,
        color: AppColor.textColor,
      )),
  MovieMenuBarTwo(
      "Поддержка",
      Icon(
        Icons.support_agent,
        size: 20,
        color: AppColor.textColor,
      )),
  MovieMenuBarTwo(
      "Инфо",
      Icon(
        Icons.info,
        size: 20,
        color: AppColor.textColor,
      )),
];
