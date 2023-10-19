import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:themoviedb/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.second).existsSync(), isTrue);
    expect(File(AppImages.balerina).existsSync(), isTrue);
    expect(File(AppImages.bluebeetle).existsSync(), isTrue);
    expect(File(AppImages.equalize).existsSync(), isTrue);
    expect(File(AppImages.goingnohier).existsSync(), isTrue);
    expect(File(AppImages.meg2).existsSync(), isTrue);
    expect(File(AppImages.mission).existsSync(), isTrue);
    expect(File(AppImages.mission2).existsSync(), isTrue);
    expect(File(AppImages.monakh).existsSync(), isTrue);
    expect(File(AppImages.moviemk).existsSync(), isTrue);
    expect(File(AppImages.songsvoboda).existsSync(), isTrue);
    expect(File(AppImages.threedemons).existsSync(), isTrue);
  });
}
