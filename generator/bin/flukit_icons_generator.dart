import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:flukit_icons_generator/icons/index.dart';
import 'package:flukit_icons_generator/icons/unicons.dart';
import 'package:flukit_icons_generator/templates/icons.dart';
import 'package:path/path.dart' as path;

const String cliName = 'flukit_icons_generator',
    cliDescription = 'Generate vector icons for flutter.';

void main(List<String> args) async {
  final runner = CommandRunner(cliName, cliDescription)
    ..addCommand(GenerateCommand());

  try {
    await runner.run([cliName, ...args]);
  } on UsageException catch (error) {
    stdout.writeln(error);
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
      final outputFile = File(
        Directory.current.uri
            .resolve('../lib/icons.dart')
            .path
            .replaceFirst('/', ''),
      );

      List<IconModel> icons =
          (json.decode(file.readAsStringSync())['icons'] as List<dynamic>)
                  .map((e) => IconModel.fromJson(e))
                  .toList() +
              Unicon.getIcons();

      String nameGetterCode = extensionGetter
          .replaceAll('%NAME%', 'name')
          .replaceAll('%TYPE%', 'String')
          .replaceAll(
              '%CONTENT%',
              icons
                  .map((icon) =>
                      '%INDENT%%INDENT%%INDENT%case FluIcons.${icon.displayName}:\n%INDENT%%INDENT%%INDENT%%INDENT%return \'${icon.name}\';')
                  .toList()
                  .join('\n\n'));
      String categoryGetterCode = extensionGetter
          .replaceAll('%NAME%', 'category')
          .replaceAll('%TYPE%', 'String')
          .replaceAll(
              '%CONTENT%',
              icons
                  .map((icon) =>
                      '%INDENT%%INDENT%%INDENT%case FluIcons.${icon.displayName}:\n%INDENT%%INDENT%%INDENT%%INDENT%return \'${icon.category}\';')
                  .toList()
                  .join('\n\n'));
      String pathsGetterCode = extensionGetter
          .replaceAll('%NAME%', 'paths')
          .replaceAll('%TYPE%', 'Map<String, String?>')
          .replaceAll(
              '%CONTENT%',
              icons
                  .map((icon) =>
                      '%INDENT%%INDENT%%INDENT%case FluIcons.${icon.displayName}:\n%INDENT%%INDENT%%INDENT%%INDENT%return ${json.encode(icon.paths)};')
                  .toList()
                  .join('\n\n'));

      if (!outputFile.existsSync()) outputFile.createSync();
      /* outputFile.writeAsStringSync(fluIconsCode
          .replaceAll('%CODE%', IconModel.generateCode(icons))
          .replaceAll('%INDENT%', '  ')); */

      outputFile.writeAsStringSync(fluIconsCode
          .replaceAll('%NAMES%',
              icons.map((icon) => '%INDENT%${icon.displayName}').join(',\n'))
          .replaceAll('%DATA%',
              [nameGetterCode, categoryGetterCode, pathsGetterCode].join('\n\n'))
          .replaceAll('%INDENT%', '  '));

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
