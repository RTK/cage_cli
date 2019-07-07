// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'logger.dart';

import 'generate/generate_command.dart';
import 'version/version_command.dart';

/// The cli runner instance.
class CageCliRunner extends CommandRunner {
  static const String _Description =
      'Command line interface program for the cage framework.';

  static const String _Name = 'cage';

  static const String _VerboseOption = 'verbose';

  CageCliRunner() : super(_Name, _Description) {
    argParser.addFlag(_VerboseOption,
        abbr: 'v',
        help: 'Output extra logging information.',
        defaultsTo: false);

    addCommand(new GenerateCommand());
    addCommand(new VersionCommand());
  }

  Future run(final Iterable<String> arguments) async {
    final ArgResults option = super.parse(arguments);

    if (option[_VerboseOption]) {
      enableLogging(Level.ALL);
    } else {
      enableLogging(Level.INFO);
    }

    await runCommand(option);
  }
}
