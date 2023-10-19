import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviedb/widgets/movie_list/movie_list.dart';

import 'movie_details_main_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key, required this.movieId});
  final int movieId;
  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}
class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
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
      body:ColoredBox(
        color: Color(0xFF202020),
        child: ListView(
          children: const [
            MovieDetailsMainInfoWidget()
          ],
        ),
      ),
    );
  }
}
