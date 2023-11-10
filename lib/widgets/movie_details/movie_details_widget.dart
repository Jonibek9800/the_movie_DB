import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_main_screen_cast_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

import 'movie_details_main_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  // @override
  // void initState() {
  //   super.initState();
  //   final movieModel =
  //       Provider.of<MovieDetailsViewModel>(context, listen: false);
  //   final appModel = Provider.of<MyAppModel>(context, listen: false);
  //   movieModel.onSessionExpaired = () => appModel.resetSession();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MovieDetailsViewModel>(context, listen: false)
        .setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          // leading: IconButton(onPressed: () => scaffoldKy.currentState?.openDrawer(), icon: Icon(Icons.menu,color: Colors.white,)),
          title: const _TitleWidget(),
          backgroundColor: const Color(0xFF022B41),
          elevation: 50.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: const ColoredBox(
          color: Color(0xFF202020),
          child: _BodyWidget(),
        ));
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context);
    return Text(
      model.model.moviesDatails?.title ?? 'Загрузка...',
      style: const TextStyle(
        color: Color(0xFF20B9D6),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        Provider.of<MovieDetailsViewModel>(context).model.moviesDatails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        MovieDetailsMainInfoWidget(),
        const SizedBox(
          height: 25,
        ),
        MovieDetailsMainScreenCastWidget(),
      ],
    );
  }
}
