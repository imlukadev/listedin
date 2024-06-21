import 'package:listedin/app/data/model/category.dart';

class CategoryReport {

  Category category;
  int currentMonthPurchasedQuantity;
  int totalPurchasedQuantity;
  double totalSpent;
  double totalSpentCurrentMonth;

  CategoryReport(this.category, this.currentMonthPurchasedQuantity, this.totalPurchasedQuantity, this.totalSpent, this.totalSpentCurrentMonth);

  factory CategoryReport.fromJSON(Map<String, dynamic> map) {
    return CategoryReport(

        Category.fromJSON(map['category']),
        map['currentMonthPurchasedQuantity'], map['totalPurchasedQuantity'], 
        map['totalSpent'], map['totalSpentCurrentMonth']
        );
  }

}