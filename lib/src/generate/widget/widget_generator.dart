//  Copyright Rouven T. Kruse. All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be
//  found in the LICENSE file.

import 'package:path/path.dart' as Path;

import 'package:cage_cli/src/generator.dart';

enum _TemplateTypes { WidgetContainer, Meta, Presenter, View }

class WidgetGenerator extends CageSourceGenerator {
  static const Map<_TemplateTypes, List<String>> _TemplateInfo = {
    _TemplateTypes.WidgetContainer: ['templates/widget/widget.dart.mustache'],
    _TemplateTypes.Meta: [
      'templates/widget/widget_meta.dart.mustache',
      '_meta'
    ],
    _TemplateTypes.Presenter: [
      'templates/widget/widget_presenter.dart.mustache',
      '_presenter'
    ],
    _TemplateTypes.View: ['templates/widget/widget_view.dart.mustache', '_view']
  };

  WidgetGenerator(final String path) : super(path);

  @override
  Future<void> generate() {
    destinationPath = Path.join(destinationPath, baseName);

    _TemplateInfo.forEach(
        (final _TemplateTypes type, final List<String> tplInfo) async {
      final String templateSource = tplInfo[0];

      final String fileName =
          baseName + (tplInfo.length > 1 ? tplInfo[1] : '') + '.dart';

      final String tplOutput = await createTemplate(templateSource, fileName, {
        'fileName': baseName,
        'widgetName': className,
        'widgetObjectName': className[0].toLowerCase() + className.substring(1)
      });

      final String destinationFile = Path.join(destinationPath, fileName);

      await writeFile(
          destinationFile, formatDartCode(tplOutput, destinationFile));
    });

    return Future.value();
  }
}
