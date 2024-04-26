
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class File {
  int id;
  String name;
  String type;
  Uint8List data;

  File(this.id, this.name, this.type, this.data);
  factory File.fromJson(Map<String, dynamic> map) {
    return File(map["id"], map["name"], map["type"], map["data"]);
  }
}
