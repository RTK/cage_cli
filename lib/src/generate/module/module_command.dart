//  Copyright Rouven T. Kruse. All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be
//  found in the LICENSE file.

import 'module_generator.dart';

import 'package:cage_cli/src/command.dart';

class ModuleCommand extends CageCliCommand {
  @override
  List<String> get aliases => ['m'];

  @override
  String get description => 'Generates a caged module.';

  @override
  String get example => '${CageCliCommand.Executable} generate module test';

  @override
  String get invocation =>
      '${CageCliCommand.Executable} generate module <module name>';

  @override
  String get name => 'module';

  Future<void> run() async {
    return ModuleGenerator(getFirstArgument()).generate();
  }
}
