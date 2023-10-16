import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviedb/widgets/navigation/botom_nav_widget.dart';
import 'package:themoviedb/widgets/navigation/drawer_nav_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});


  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedPage = 0;

  onSelect(int index) {
    if(_selectedPage == index) return;
    setState(() {
      _selectedPage = index;
    });
  }
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Главная',
      style: optionStyle,
    ),
    Text(
      'Фильмы',
      style: optionStyle,
    ),
    Text(
      'Сериалы',
      style: optionStyle,
    ),
  ];

  var scaffoldKy = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKy,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        // leading: IconButton(onPressed: () => scaffoldKy.currentState?.openDrawer(), icon: Icon(Icons.menu,color: Colors.white,)),
        title: const Text(
          "The Movie DB",
          style: TextStyle(
            color: Color(0xFF20B9D6),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            tooltip: 'Comment Icon',
            onPressed: () {},
            color: Colors.white,
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Setting Icon',
            onPressed: () {},
            color: Colors.white,
          ), //IconButton
        ],
        //<Widget>[]
        backgroundColor: const Color(0xFF022B41),
        elevation: 50.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      drawer: const DrawerNavWidget(),
      body: Center(
        child: _widgetOptions[_selectedPage],
      ),
      bottomNavigationBar: BotomNavigationWidget(select: _selectedPage, onSelect: onSelect,)
    );
  }
}
