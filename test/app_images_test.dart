import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:themoviedb/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.person).existsSync(), isTrue);
  });
}
