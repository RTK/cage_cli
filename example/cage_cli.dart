import 'package:cage_cli/cage_cli.dart';

final CageCliRunner runner = CageCliRunner();

void main() {
  _genModules();
  _genServices();
  _genWidgets();
}

void _genModules() {
  // generate module in /lib/src/test_module.dart
  runner.run(['generate', 'module', 'test']);
  // generate module in /lib/src/test/test_module.dart
  runner.run(['generate', 'module', 'test/test']);
}

void _genServices() {
  // generate service in /lib/src/test_service.dart
  runner.run(['generate', 'service', 'test']);
  // generate service in /lib/src/test/_services/test_service.dart
  runner.run(['generate', 'service', 'test/_services/test']);
}

void _genWidgets() {
  // generate widget source files in /lib/src
  // -> test.dart
  // -> test_meta.dart
  // -> test_presenter.dart
  // -> test_view.dart
  runner.run(['generate', 'widget', 'test']);
}
