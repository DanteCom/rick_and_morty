import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/shared/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.boy).existsSync(), isTrue);
    expect(File(Images.cucumber).existsSync(), isTrue);
    expect(File(Images.episode).existsSync(), isTrue);
    expect(File(Images.location).existsSync(), isTrue);
    expect(File(Images.planet).existsSync(), isTrue);
    expect(File(Images.splashBackground).existsSync(), isTrue);
    expect(File(Images.splashForeground).existsSync(), isTrue);
  });
}
