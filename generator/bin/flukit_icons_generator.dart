import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;

const String cliName = 'flukit_icons_generator',
    cliDescription = 'Generate vector icons for flutter.';

void main(List<String> args) async {
  final runner = CommandRunner(cliName, cliDescription)
    ..addCommand(GenerateCommand());

  try {
    await runner.run([cliName, ...args]);
  } on UsageException catch (error) {
    print(error);
    exit(1);
  }
}

class GenerateCommand extends Command {
  GenerateCommand();

  final String indent = '  ';

  @override
  String get name => cliName;

  @override
  String get description => cliDescription;

  @override
  Future<void> run() async {
    await getJsonFile().then((file) {
      final data = json.decode(file.readAsStringSync());
      final List<IconModel> icons = [];

      for (var icon in data['icons']) {
        icons.add(IconModel.fromJson(icon));
      }

      final List<String> iconsList = icons.map((e) {
        String name = RegExp(r'^\d+$').hasMatch(e.name[0])
            ? '${e.category}_${e.name}'
            : e.name;

        return '%INDENT%static FluIconModel $name = ${e.toString()};';
      }).toList();
      final code =
          'import \'package:flutter/material.dart\';\nimport \'model.dart\';\n\n@immutable\nclass FluIcons {\n%INDENT%const FluIcons._();\n\n${iconsList.join("\n\n")}\n}';

      final outputFile = File(
        Directory.current.uri
            .resolve('../lib/icons.dart')
            .path
            .replaceFirst('/', ''),
      );

      if (!outputFile.existsSync()) outputFile.createSync();

      outputFile.writeAsStringSync(code.replaceAll('%INDENT%', '  '));

      stdout.writeln('Done !');
    }).catchError((err) {
      stdout.writeln(err);
    });
  }

  Future<File> getJsonFile() {
    final localDir = Directory.fromUri(Platform.script.resolve('../../icons'));
    final json = File(path.join(localDir.path, 'icons.json'));

    if (!localDir.existsSync() && !json.existsSync()) {
      return Future.error('Download icons first !!!');
    }

    return Future.value(json);
  }
}

class IconModel {
  String name, category;
  Map<String, String?> datas;

  IconModel({
    required this.name,
    required this.category,
    required this.datas,
  });

  factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
        name: json['name'],
        category: json['category'],
        datas: {
          'broken': json['datas']['broken']?.toString(),
          'bulk': json['datas']['bulk']?.toString(),
          'linear': json['datas']['linear']?.toString(),
          'twotone': json['datas']['twotone']?.toString(),
        },
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "category": category,
      "datas": datas,
    };
  }

  @override
  String toString() {
    return '''FluIconModel(
      name: ${json.encode(name)},
      category: ${json.encode(category)},
      datas: ${json.encode(datas)},
    )''';
  }
}
