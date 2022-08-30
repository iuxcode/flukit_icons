import 'dart:convert';
import 'package:recase/recase.dart';

class IconModel {
  String name, category;
  Map<String, String?> paths;

  IconModel({
    required this.name,
    required this.category,
    required this.paths,
  });

  String get displayName =>
      ReCase(isNum(name[0]) ? '${category}_$name' : name).camelCase;

  factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
        name: json['name'],
        category: json['category'],
        paths: {
          'broken': json['paths']['broken']?.toString(),
          'bulk': json['paths']['bulk']?.toString(),
          'linear': json['paths']['linear']?.toString(),
          'twotone': json['paths']['twotone']?.toString(),
        },
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "category": category,
      "paths": paths,
    };
  }

  @override
  String toString() {
    return '''FluIconData(
      name: ${json.encode(name)},
      category: ${json.encode(category)},
      paths: ${json.encode(paths)},
    )''';
  }

  static String generateCode(List<IconModel> icons) {
    return icons
        .map((e) {
          String name = ReCase(isNum(e.name[0]) ? '${e.category}_${e.name}' : e.name)
              .camelCase;

          return '%INDENT%static FluIconData $name = ${e.toString()};';
        })
        .toList()
        .join("\n");
  }
}

bool isNum(String string) => RegExp(r'^\d+$').hasMatch(string);
