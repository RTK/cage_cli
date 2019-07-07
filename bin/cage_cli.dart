// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:cage_cli/cage_cli.dart';
import 'package:args/command_runner.dart';

/// Entry point for the cli. Creates a [CageCliRunner] and passes the arguments
/// as a [List].
Future main(List<String> args) async {
  final CageCliRunner runner = CageCliRunner();

  try {
    return await runner.run(args);
  } on UsageException catch (error) {
    print(error);
    print(runner.usage);

    await Future.wait([stdout.close(), stderr.close()]);

    exit(64);
  }
}
