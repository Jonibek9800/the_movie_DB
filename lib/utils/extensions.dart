import 'package:themoviedb/domain/entity/movie_credits.dart';

extension MovieCreditsEx on List<Cast>{
  List<Cast> sortedTwentyList(){

    if(length >= 10){
     return take(10).toList();
    }
    return this;
  }
}