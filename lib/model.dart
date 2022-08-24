class FluIconModel {
  String name, category;
  Map<String, dynamic> datas;

  FluIconModel({
    required this.name,
    required this.category,
    required this.datas,
  });

  factory FluIconModel.fromJson(Map<String, dynamic> json) => FluIconModel(
        name: json['name'],
        category: json['category'],
        datas: json['datas'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "category": category,
      "datas": datas,
    };
  }
}
