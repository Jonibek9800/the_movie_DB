import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';

class BotomNavigationWidget extends StatelessWidget {
  final select;
  final onSelect;
  const BotomNavigationWidget({super.key, required this.select, required this.onSelect,});

  // get onSelect => null;

  @override
  Widget build(BuildContext context) {
    // int selectedPage = this.select;
    return BottomNavigationBar(
      selectedItemColor: AppColor.textColor,
      currentIndex: select,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.slow_motion_video,),
          label: 'Фильмы',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_movies_rounded,),
          label: 'Сериалы',
        ),
      ],
      onTap: onSelect,
    );
  }
}
