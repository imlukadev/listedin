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
  List<ProductList> products;
  List<Scheduling> schedulings;

  ShopList(this.id, this.name, this.isFavorited, this.lastAccess,
      this.purchasedQuantity, this.categories, this.products, this.schedulings);

  factory ShopList.fromJSON(Map<String, dynamic> map) {
    return ShopList(
        map['id'],
        map['name'],
        map['isFavorited'],
        DateTime.parse(map['lastAccess']),
        map['purchasedQuantity'],
        map['categories']
            .map((category) =>
                Category.fromJSON(category as Map<String, dynamic>))
            .toList(),
        map['products']
            .map((products) => ProductList.fromJson(products))
            .toList(),
        map['schedulings']
            .map((scheduling) => Scheduling.fromJSON(scheduling)));
  }
}
