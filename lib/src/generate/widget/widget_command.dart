// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'widget_generator.dart';

import 'package:cage_cli/src/command.dart';

class WidgetCommand extends CageCliCommand {
  @override
  List<String> get aliases => ['w'];

  @override
  String get description => 'Generates a caged widget.';

  @override
  String get example =>
      '${CageCliCommand.Executable} generate service example/test';

  @override
  String get invocation =>
      '${CageCliCommand.Executable} generate widget <path>';

  @override
  String get name => 'widget';

  Future<void> run() async {
    return WidgetGenerator(getFirstArgument()).generate();
  }
}
