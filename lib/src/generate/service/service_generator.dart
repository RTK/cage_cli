// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:path/path.dart' as Path;

import 'package:cage_cli/src/generator.dart';

class ServiceGenerator extends CageSourceGenerator {
  static const String _TemplatePath = 'templates/service/service.dart.mustache';

  ServiceGenerator(final String path)
      : super(path, fileNameAppendix: '_service', removePathExtensions: true);

  Future<void> generate() async {
    final String destinationFile = Path.join(destinationPath, fileName);

    final String tplOutput =
        await createTemplate(_TemplatePath, fileName, {'name': className});

    return writeFile(
        destinationFile, formatDartCode(tplOutput, destinationFile));
  }
}
