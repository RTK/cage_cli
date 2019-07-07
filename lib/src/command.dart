//  Copyright Rouven T. Kruse. All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be
//  found in the LICENSE file.

import 'package:args/command_runner.dart';

export 'package:args/args.dart';
export 'package:args/command_runner.dart' show UsageException;

import 'logger.dart';

/// Represents the base class for any [Command] in the cli.
abstract class CageCliCommand extends Command {
  static const String Executable = 'cage';

  String get example;

  Logger get logger => Logger(name);

  /// Returns the first argument to be used.
  ///
  /// Example: cage generate service
  ///
  /// This method will return "generate" as it is the first argument
  ///
  /// If the argument [List] is empty, an [UsageException] is thrown.
  String getFirstArgument() {
    final List<String> args = argResults.rest;

    if (args == null || args.isEmpty) {
      throw UsageException('A valid path must be provided.', example);
    }

    return args[0];
  }
}
