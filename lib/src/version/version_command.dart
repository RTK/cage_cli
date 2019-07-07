// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

import '../command.dart';

class VersionCommand extends CageCliCommand {
  @override
  List<String> get aliases => ['v'];

  @override
  String get description => 'Get the current cli version.';

  @override
  String get example => '${CageCliCommand.Executable} version';

  @override
  String get name => 'version';

  Future<String> run() async {
    logger.config('Reading version from pubspec');

    final File pubspec = File('pubspec.yaml');

    if (!pubspec.existsSync()) {
      throw StateError('Pubspec cannot be located.');
    }

    final dynamic pubspecEntries =
        loadYaml(pubspec.readAsStringSync(encoding: utf8));

    if (pubspecEntries['version'] == null) {
      throw StateError('"Version" property cannot be accessed.');
    }

    final String version = 'v${pubspecEntries['version']}';

    logger.info(version);

    return version;
  }
}
