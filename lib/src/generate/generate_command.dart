// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'module/module_command.dart';
import 'service/service_command.dart';
import 'widget/widget_command.dart';

import 'package:cage_cli/src/command.dart';

class GenerateCommand extends CageCliCommand {
  @override
  List<String> get aliases => ['g'];

  @override
  String get example =>
      '${CageCliCommand.Executable} generate <module|service|widget>';

  @override
  String get description => 'Generate widget or service.';

  String get invocation => '${CageCliCommand.Executable} generate <service>';

  @override
  String get name => 'generate';

  GenerateCommand() {
    addSubcommand(ModuleCommand());
    addSubcommand(ServiceCommand());
    addSubcommand(WidgetCommand());
  }
}
