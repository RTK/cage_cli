//  Copyright Rouven T. Kruse. All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be
//  found in the LICENSE file.

import 'package:cage_cli/src/logger.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    if (logSubscription != null) {
      disableLogging();
    }
  });

  group('createLogger()', () {
    test('it should create an instance', () {
      expect(createLogger('test'), isNotNull);
    });

    test(
        'it should return always the same instance for loggers with identical names',
        () {
      expect(createLogger('test'), createLogger('test'));
    });
  });

  group('disableLogging', () {
    test('it should throw, when logging is already disabled', () {
      expect(logSubscription, isNull);
      expect(() => disableLogging(), throwsException);
    });
  });

  group('enableLogging()', () {
    test('it should throw, when logging is already enabled', () {
      enableLogging(Level.ALL);
      expect(() => enableLogging(Level.CONFIG), throwsException);
    });

    test('it should redirect logs to the logFn', () {
      bool wasCalled = false;

      enableLogging(Level.ALL);

      logFn = (Object obj) {
        wasCalled = true;
      };

      createLogger('test').info('test');

      expect(wasCalled, true);
    });
  });
}
