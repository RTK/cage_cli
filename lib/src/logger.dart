// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

export 'package:logging/logging.dart' show Level, Logger;

typedef _LogFn = void Function(Object object);

@visibleForTesting
_LogFn logFn = print;

@visibleForTesting
StreamSubscription logSubscription;

Logger createLogger(final String name) => Logger(name);

void disableLogging() {
  if (logSubscription != null) {
    logSubscription.cancel();

    logSubscription = null;
  } else {
    throw Exception('Logging is not yet enabled.');
  }
}

void enableLogging(final Level level) {
  if (logSubscription == null) {
    logSubscription = Logger.root.onRecord.listen((final LogRecord logRecord) {
      logFn(logRecord.message);
    });
  } else {
    throw Exception('Logging already is enabled.');
  }
}
