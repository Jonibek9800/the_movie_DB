import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_state.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';
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
    if (_selectedPage == index) return;
    setState(() {
      _selectedPage = index;
    });
  }

  final _screenFactory = ScreenFactorey();

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
              tooltip: 'Auth Icon',
              onPressed: () => SessionDataProvider().setSessionId(null),
              color: Colors.white,
            ), //IconButton
            BlocBuilder<CartBloc, CartBlocState>(builder: (context, state) {
              var currentState = state.cartBlocModel;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  onPressed: () => [],
                  icon:  badges.Badge(
                    badgeContent: Text('${currentState.cartQty()}'),
                    child: const Icon(Icons.shopping_cart),
                  ),
                ),
              );
            }) //IconButton
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
            _screenFactory.makeHome(),
            _screenFactory.makeMovieList(),
            _screenFactory.makeSerials()
            // Text(
            //   'Главная',
            //   style: optionStyle,
            // ),
            // MovieListWidget(),
            // Text(
            //   'Сериалы',
            //   style: optionStyle,
            // ),
          ],
        ),
        bottomNavigationBar: BotomNavigationWidget(
          select: _selectedPage,
          onSelect: onSelect,
        ));
  }
}
