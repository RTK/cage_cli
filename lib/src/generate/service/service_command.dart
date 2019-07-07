// Copyright Rouven T. Kruse. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'service_generator.dart';

import 'package:cage_cli/src/command.dart';

class ServiceCommand extends CageCliCommand {
  @override
  List<String> get aliases => ['s'];

  @override
  String get description => 'Generates a service.';

  @override
  String get example =>
      '${CageCliCommand.Executable} generate service example/_services/my';

  @override
  String get invocation =>
      '${CageCliCommand.Executable} generate service <path>';

  @override
  String get name => 'service';

  Future<void> run() async {
    return await ServiceGenerator(getFirstArgument()).generate();
  }
}
