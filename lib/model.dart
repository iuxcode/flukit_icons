class FluIconData {
  String name, category;
  Map<String, dynamic> datas;

  FluIconData({
    required this.name,
    required this.category,
    required this.datas,
  });

  factory FluIconData.fromJson(Map<String, dynamic> json) => FluIconData(
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
