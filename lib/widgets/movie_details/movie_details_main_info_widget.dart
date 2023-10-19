import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

import '../element/radial_percent_widget.dart';

// import '../../../../radial_percent/lib/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: const _TopPostersWidget()),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: _MoviesNameWidget(),
        ),
        const _ScoreWidget(),
        Container(
          color: const Color(0xFF1D1D1D),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: const _SummeryWidget(),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              "We all share the same fate.",
              style: TextStyle(color: Colors.grey, fontSize: 17.6),
            )),
        const _ReviewWidget(),
        const _PeopleWidget()
      ],
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Image(
            image: AssetImage(AppImages.mission2),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 15,
          child: Container(
            child: const Image(
              image: AssetImage(AppImages.mission),
              width: 100,
            ),
          ),
        ),
      ],
    );
  }
}

class _MoviesNameWidget extends StatelessWidget {
  const _MoviesNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        maxLines: null,
        text: const TextSpan(children: [
          TextSpan(
              text: "Миссия невыполнима: Смертельная расплата. Часть первая",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          TextSpan(
              text: " (2023)",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey))
        ]));
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double percent = 77;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  child: RadialPercentWidget(
                    percent: percent,
                    fillColor: Colors.black,
                    freeColor: Colors.grey,
                    lineColor: Colors.green,
                    lineWidth: 3,
                    child: Text("${percent.toInt()}%", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  'Рейтинг',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
        Container(
          color: Colors.grey,
          width: 2,
          height: 15,
        ),
        TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Воспроизвести трейлер',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        maxLines: 4,
        text: const TextSpan(children: [
          TextSpan(
              text: "PG-13",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromRGBO(255, 255, 255, 0.6))),
          TextSpan(
              text: " 12/07/2023 (US) * 2h 44m боевик, триллер",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white))
        ]));
  }
}

class _ReviewWidget extends StatelessWidget {
  const _ReviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Обзор",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600),
            )),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "Итан Хант и его команда противостоят системе искусственного интеллекта Entity, которая вышла из под контроля и стала угрозой человечества.",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({
    super.key,
  });

  static const manStyle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700);
  static const jobStyle = TextStyle(color: Colors.white, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Christopher McQuarrie",
                  style: manStyle,
                ),
                Text(
                  "Director, Writer",
                  style: jobStyle,
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Erik Jendresen",
                  style: manStyle,
                ),
                Text(
                  "Writer",
                  style: jobStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
