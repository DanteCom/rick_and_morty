import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/shared/resources/resources.dart';

void main() {
  test('vectors assets test', () {
    expect(File(Vectors.arrowBack).existsSync(), isTrue);
    expect(File(Vectors.arrowRight).existsSync(), isTrue);
    expect(File(Vectors.character).existsSync(), isTrue);
    expect(File(Vectors.episode).existsSync(), isTrue);
    expect(File(Vectors.filter).existsSync(), isTrue);
    expect(File(Vectors.grid).existsSync(), isTrue);
    expect(File(Vectors.heart).existsSync(), isTrue);
    expect(File(Vectors.heartOutline).existsSync(), isTrue);
    expect(File(Vectors.location).existsSync(), isTrue);
    expect(File(Vectors.menu).existsSync(), isTrue);
    expect(File(Vectors.search).existsSync(), isTrue);
    expect(File(Vectors.settings).existsSync(), isTrue);
  });
}
