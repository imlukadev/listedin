import 'package:listedin/app/data/model/categoryReport.dart';

class Report {
  List<CategoryReport> categoryReports;
  double totalSpent;
  double totalSpentCurrentMonth;

  int totalListsPurchased;
  int totalProductsPurchased;
  double averagePurchasedProductsPerList;
  double averagePurchasedProductPrice;

  Report(this.categoryReports, this.totalSpent, this.totalSpentCurrentMonth, this.totalListsPurchased, this.totalProductsPurchased, this.averagePurchasedProductsPerList, this.averagePurchasedProductPrice);

  factory Report.fromJSON(Map<String, dynamic> map) {
    return Report(

        (map['categoryReports'] as List<dynamic>)
            .map((list) => CategoryReport.fromJSON(list))
            .toList(),
        map['totalSpent'], map['totalSpentCurrentMonth'], 
        map['totalListsPurchased'], map['totalProductsPurchased'], 
        map['averagePurchasedProductsPerList'], map['averagePurchasedProductPrice'], 
        
        );
  }

  // Map<String, dynamic> toJSON() {
  //   Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data["name"] = name;
  //   data["price"] = price;
  //   data["category"] = category.toJSON();
  //   return data;
  // }

  // Map<String, dynamic> toCreateJSON() {
  //   Map<String, dynamic> data = <String, dynamic>{};
  //   data["name"] = name;
  //   data["price"] = price;
  //   data["category"] = category.toJSON();
  //   data["user"] = user!.toSimpleJSON();
  //   return data;
  // }
}
