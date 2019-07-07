//  Copyright Rouven T. Kruse. All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be
//  found in the LICENSE file.

import 'package:path/path.dart' as Path;

import 'package:cage_cli/src/generator.dart';

class ModuleGenerator extends CageSourceGenerator {
  static const String _TemplatePath = 'templates/module/module.dart.mustache';

  ModuleGenerator(final String path)
      : super(path, fileNameAppendix: '_module', removePathExtensions: true);

  @override
  Future<void> generate() async {
    final String destinationFile =
        Path.join(destinationPath, baseName, fileName);

    final String tplOutput = await createTemplate(_TemplatePath, fileName, {
      'keyName': className,
      'moduleName': className[0].toLowerCase() + className.substring(1)
    });

    return writeFile(
        destinationFile, formatDartCode(tplOutput, destinationFile));
  }
}
