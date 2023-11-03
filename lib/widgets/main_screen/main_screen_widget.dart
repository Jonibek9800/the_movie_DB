import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/domain/data_providerss/session_data_provider.dart';
import 'package:themoviedb/widgets/app/my_app_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list.dart';
import 'package:themoviedb/widgets/navigation/botom_nav_widget.dart';
import 'package:themoviedb/widgets/navigation/drawer_nav_widget.dart';

import '../movie_list/movie_list_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedPage = 0;

  onSelect(int index) {
    if (_selectedPage == index) return;
    setState(() {
      _selectedPage = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final movieListModel = MovieListViewModel();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final movieListModel = Provider.of<MovieListViewModel>(context,listen: false);
      movieListModel.setupLocal(context);
    });
  }

  // @override
  // void didChangeDependencies() {
  //
  //   super.didChangeDependencies();
  // }

  var scaffoldKy = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<MyAppModel>(context);

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
              tooltip: 'Auth Icon',
              onPressed: () => SessionDataProvider().setSessionId(null),
              color: Colors.white,
            ), //IconButton
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search Icon',
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
        body: IndexedStack(
          index: _selectedPage,
          children: [
            const Text(
              'Главная',
              style: optionStyle,
            ),
            MovieListWidget(),
            const Text(
              'Сериалы',
              style: optionStyle,
            ),
          ],
        ),
        bottomNavigationBar: BotomNavigationWidget(
          select: _selectedPage,
          onSelect: onSelect,
        ));
  }
}
