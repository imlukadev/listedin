import 'dart:ui';

class Category {
  int id;
  String name;
  Color color;
  Category(this.id, this.name, this.color);

  factory Category.fromJSON(Map<String, dynamic> map) {
    Color color = Color(int.parse(map['color'].replaceAll('#', '0xFF')));
    return Category(map['id'], map['name'], color);
  }
  String colorToJson(Color color) {
    return "#${color.value.toRadixString(16).padLeft(8, '0')}";
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data["color"] = colorToJson(color);
    return data;
  }
}
