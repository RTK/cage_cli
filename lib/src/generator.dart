//  Copyright Rouven T. Kruse. All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be
//  found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:mustache/mustache.dart' as Mustache;
import 'package:path/path.dart' as Path;
import 'package:resource/resource.dart';

import 'logger.dart';

/// Base class for source file generators.
abstract class CageSourceGenerator {
  static final DartFormatter _dartFormatter = DartFormatter();

  final String classAppendix;

  final String fileNameAppendix;

  final String path;

  final bool removePathExtensions;

  String baseName;

  String className;

  String destinationPath;

  String dirName;

  String fileName;

  Logger _logger;

  CageSourceGenerator(this.path,
      {this.classAppendix = '',
      this.fileNameAppendix = '',
      this.removePathExtensions = false}) {
    _logger = createLogger('Generator');

    dirName = Path.dirname(path).replaceAll(RegExp('\/'), Path.separator);

    destinationPath = Path.join('lib', 'src', dirName != '.' ? dirName : '');

    baseName = Path.basename(path).toLowerCase().replaceAll(RegExp('-'), '_');

    fileName = baseName;

    if (removePathExtensions && RegExp('.*\.[a-zA-Z]}\$').hasMatch(fileName)) {
      fileName = fileName.replaceFirst(RegExp('.*(\.[a-zA-Z])\$'), '');
    }

    className = _genClassName(fileName);

    if (!fileName.endsWith(fileNameAppendix)) {
      fileName += fileNameAppendix;
    }

    fileName += '.dart';
  }

  /// Creates and renders a mustache template from given [path]. The template
  /// will receive the [fileName] passed and the passed [replacements].
  /// The [replacements] represent values that will replace variables in the
  /// template.
  Future<String> createTemplate(final String path, final String fileName,
      final dynamic replacements) async {
    _logger.config('Creating template $fileName');

    final Resource resource = Resource('package:cage_cli/$path');
    final String resourceString = await resource.readAsString(encoding: utf8);

    final Mustache.Template template =
        Mustache.Template(resourceString, name: fileName);

    return template.renderString(replacements);
  }

  /// Formats the [inputDartCode] with the [DartFormatter], so that all source
  /// files will be equally structured.
  String formatDartCode(final String inputDartCode, final String fileName) {
    try {
      return _dartFormatter.format(inputDartCode);
    } catch (e) {
      _logger.warning('Error formatting dart code in file $fileName');

      throw e;
    }
  }

  /// Generate abstract function, to be overwritten.
  Future<void> generate();

  /// Writes a file to the [path] with given [contents].
  ///
  /// If a file with that [path] already exists, a [StateError] is thrown.
  ///
  /// If any parent does not yet exist, it will be created.
  Future<void> writeFile(final String path, final String contents) async {
    final File file = File(path);

    if (file.existsSync()) {
      throw StateError('File $path already exists');
    }

    if (!file.parent.existsSync()) {
      _logger.config('Creating parent directories');

      file.parent.createSync(recursive: true);
    }

    file.writeAsStringSync(contents);

    _logger.info('Successfully generated file "$path"');
  }

  /// Generates the class name for the files.
  ///
  /// Example:
  /// input: file_name_dart
  /// output: FileNameDart
  String _genClassName(final String fileName) {
    String className = '';

    for (final String splitString in fileName.split('_')) {
      className += splitString[0].toUpperCase() + splitString.substring(1);
    }

    return className + classAppendix;
  }
}
