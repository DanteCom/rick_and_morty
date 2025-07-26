import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app/shared/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.episode).existsSync(), isTrue);
    expect(File(Images.location).existsSync(), isTrue);
    expect(File(Images.splashBackground).existsSync(), isTrue);
    expect(File(Images.splashForeground).existsSync(), isTrue);
  });
}
