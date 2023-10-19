import 'package:flutter/material.dart';
import 'package:spider/spider.dart';
import 'package:themoviedb/resources/resources.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie(
      {required this.imageName,
      required this.title,
      required this.time,
      required this.description, required this.id});
}

class MovieListWidget extends StatefulWidget {
  MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
        id: 1,
        imageName: AppImages.mission,
        title: "Миссия невыполнима: Смертельная расплата. Часть первая",
        time: "12 июля 2023",
        description:
            "Итан Хант и его команда противостоят системе искусственного "
            "интеллекта Entity, которая вышла из под контроля и стала угрозой человечества."),
    Movie(
        id: 2,
        imageName: AppImages.equalize,
        title: "Великий уравнитель 3",
        time: " 1 сентября 2023",
        description:
            "Покончив с работой тайного агента Роберт Макколл продолжает отстаивать правду в повседневной жизни и защищать тех, кто в этом нуждается. Находясь в Южной Италии он узнает, что его друзья оказались под влиянием местных криминальных авторитетов. Когда события обостряются, Макколл решает встать на защиту справедливости, вступив в борьбу с мафией."),
    Movie(
        id: 3,
        imageName: AppImages.monakh,
        title: "Проклятие монахини 2",
        time: " 8 сентября 2023",
        description:
            "1956 год, Франция. Священник убит, зло распространяется, и сестра Ирен вновь сталкивается лицом к лицу со злобной силой Валака, монахини-демона."),
    Movie(
        id: 4,
        imageName: AppImages.threedemons,
        title: "Два, три, демон, приди!",
        time: "28 июля 2023",
        description:
            "Древний ритуал, призывающий в наш мир заблудшие души, превратился в экзотическое развлечение на вечеринке. Правила просты: произнести заклятие перед мумифицированной рукой и пустить призрака в своё тело. Главное –  уложиться в минуту. Стоит нарушить ритуал, и портал уже не закрыть. Сознание участников наводнят кошмары, и живые позавидуют мертвым..."),
    Movie(
        id: 5,
        imageName: AppImages.goingnohier,
        title: "В никуда",
        time: "29 сентября 2023",
        description:
            "Молодая беременная женщина по имени Миа бежит из охваченной войной страны, спрятавшись в морском контейнере на борту грузового судна. После сильного шторма Миа рожает ребенка и оказывается в море, где ей придётся бороться за выживание."),
    Movie(
        id: 6,
        imageName: AppImages.songsvoboda,
        title: "Звук свободы",
        time: " 4 июля 2023",
        description:
            "История Тима Балларда (Джим Кэвизел), бывшего агента правительства США, который уволился с работы, чтобы посвятить свою жизнь спасению детей от сексуального рабства."),
    Movie(
        id: 7,
        imageName: AppImages.balerina,
        title: "Балерина",
        time: " 6 октября 2023",
        description:
            "Переживая потерю, бывшая телохранительница по имени Ок Джу решает исполнить последнее желание лучшей подруги, которую ей не удалось защитить. Месть так сладка."),
    Movie(
        id: 8,
        imageName: AppImages.second,
        title: "57 секунд",
        time: "29 сентября 2023",
        description:
            "Техноблогер Франклин случайно предотвращает покушение на известного визионера и инновационного гуру, достигшего невероятных успехов в сфере медицины. Подобрав оброненное им кольцо, молодой человек обнаруживает, что оно дает своему носителю возможность переноситься в прошлое на 57 секунд. Франклин решает воспользоваться находкой и с помощью чудо-кольца отомстить тем, кого он считает виновными в смерти своей сестры."),
    Movie(
        id: 9,
        imageName: AppImages.bluebeetle,
        title: "Синий Жук",
        time: "18 августа 2023",
        description:
            "Недавний выпускник колледжа Джейми Рейес возвращается домой, полный надежд на свое будущее, только для того, чтобы обнаружить, что дом не совсем такой, каким он его оставил. Пока он пытается найти свое предназначение в этом мире, вмешивается судьба, когда Джейми неожиданно оказывается обладателем древней реликвии инопланетной биотехнологии: скарабея."),
    Movie(
        id: 10,
        imageName: AppImages.meg2,
        title: "Мег 2: Бездна",
        time: " 4 августа 2023",
        description:
            "«Мег 2: Бездна» — это глоток адреналина, который ждет нас этим летом. Продолжение суперпопулярного блокбастера 2018 года поднимает экшн выше неба и погружает в невиданные глубины, кишащие мегалодонами! Погрузимся в неизведанные глубины вместе с Джейсоном Стейтемом и иконой мирового экшена Ву Джингом, чтобы исследовать самые темные места мирового океана. Их путешествие превращается в хаос, когда прошедшая операция злоумышленников грозит сорвать их миссию и заставляет их самих бороться за выживание. Столкнувшись с гигантскими акулами-мегами и неутомимыми экзопреступниками, герои должны опередить, перемудрить и превзойти безжалостных хищников в погоне наперегонки со временем."),
  ];

  final _searchController = TextEditingController();
  var _filtredMovies = <Movie>[];

  void _searchMovies() {
    final queryTitle = _searchController.text;
    if (queryTitle.isNotEmpty) {
      _filtredMovies = _movies.where((Movie movie) {
        return movie.title.trim().toLowerCase().contains(queryTitle.trim().toLowerCase());
      }).toList();
    } else {
      _filtredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filtredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTab (int index) {
      final id = _movies[index].id;
      Navigator.of(context).pushNamed("/main_screen/movie_details", arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 75),
          itemCount: _filtredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filtredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Stack(children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomLeft: Radius.circular(7)),
                          child: Image(
                            image: AssetImage(movie.imageName),
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              movie.title,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              movie.time,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              movie.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(7),
                    onTap: () => _onMovieTab(index),
                  ),
                )
              ]),
            );
          }),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
              labelText: 'Search...',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder()),
        ),
      ),
    ]);
  }
}
