//  Copyright Rouven T. Kruse. All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be
//  found in the LICENSE file.

import 'package:cage_cli/cage_cli.dart';
import 'package:cage_cli/src/logger.dart';
import 'package:test/test.dart';

void main() {
  Object logOutput;

  CageCliRunner runner;

  setUp(() {
    logOutput = null;

    logFn = (final Object obj) {
      logOutput = obj;
    };
  });

  setUp(() {
    runner = CageCliRunner();
  });

  test('It should create', () {
    expect(runner, isNotNull);
  });

  group('code generation', () {
    group('module', () {});

    group('service', () {});

    group('widget', () {});
  });

  group('version', () {
    test('It should print the correct version', () {
      runner.run(['version']);

      expect(logOutput, 'v0.1.0');
    });
  });
}
