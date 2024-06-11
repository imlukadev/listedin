import 'package:listedin/app/data/model/category.dart';
import 'package:listedin/app/data/model/product_list.dart';
import 'package:listedin/app/data/model/scheduling.dart';

class ShopList {
  int id;
  String name;
  bool isFavorited;
  DateTime lastAccess;
  int purchasedQuantity;
  List<Category> categories;
  List<ProductList>? products;
  List<Scheduling> schedulings;

  ShopList(this.id, this.name, this.isFavorited, this.lastAccess,
      this.purchasedQuantity, this.categories, this.products, this.schedulings);

  factory ShopList.fromJSON(Map<String, dynamic> map) {
    return ShopList(
        map['id'],
        map['name'] ?? "",
        map['isFavorited'] ?? false,
        // DateTime.now(),
        DateTime.parse(map['lastAccess']),
        map['purchasedQuantity'],
        // [],
        // [],
        map.keys.contains('categories')
            ? (map['categories'] as List<dynamic>)
                .map((category) =>
                    Category.fromJSON(category as Map<String, dynamic>))
                .toList()
            : [],
        map.keys.contains('products')
            ? (map['products'] as List<dynamic>)
                .map((products) => ProductList.fromJSON(products))
                .toList()
            : [],
        // []);

        map.keys.contains('schedulings')
            ? (map['schedulings'] as List<dynamic>)
                .map((scheduling) => Scheduling.fromJSON(scheduling))
                .toList()
            : []);
  }
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isFavorited'] = isFavorited;
    data['lastAccess'] = lastAccess.toString();
    data['purchasedQuantity'] = purchasedQuantity;
    data['categories'] = categories.map((e) => e.toJSON()).toList();
    data['products'] = products!.map((e) => e.toJSON()).toList();
    data['schedulings'] = schedulings.map((e) => e.toJSON()).toList();
    return data;
  }
}
