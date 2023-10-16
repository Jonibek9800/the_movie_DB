import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;


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
    setState(() {

    });
  }

   List<ExampleDestination> destinations = const <ExampleDestination>[
    ExampleDestination(
        'Фильмы', Icon(Icons.movie_creation_outlined, color: Colors.white,), Icon(Icons.movie, color: AppColor.textColor,)),
    ExampleDestination(
        'Сериалы', Icon(Icons.local_movies_outlined, color: Colors.white,), Icon(Icons.local_movies, color: AppColor.textColor,)),
    ExampleDestination(
        'Люди', Icon(Icons.people_alt_outlined, color: Colors.white,), Icon(Icons.people, color: AppColor.textColor,)),
    ExampleDestination(
        'Книга Редактора', Icon(Icons.book_outlined, color: Colors.white,), Icon(Icons.book_rounded, color: AppColor.textColor,)),
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
          child: Text(
            'Menu',
            style: TextStyle(fontSize: 16, color: AppColor.textColor)
          ),
        ),
        ...destinations.map(
              (ExampleDestination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label, style: const TextStyle(color: AppColor.textColor),),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
      ],
    );
  }
}
