import 'dart:convert';

import 'package:recase/recase.dart';

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
    return '''FluIconData(
      name: ${json.encode(name)},
      category: ${json.encode(category)},
      datas: ${json.encode(datas)},
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
