import 'package:flutter/material.dart';
import 'package:listedin/app/components/footer/footer.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/pages/stats/stats_store.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';
import 'package:listedin/app/styles/colors.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key, required this.userStore, required this.isDark});
  final UserStore userStore;
  final bool isDark;

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late StatsStore store;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    store = StatsStore(widget.userStore.state.value!);
    store.getReport();
    print(store.state.value);
    print("store.state.value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: ValueListenableBuilder(
          valueListenable: store.state,
          builder: (context, value, _) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Preço médio do produto: ${value?.averagePurchasedProductPrice}"),
                Text(
                    "Media de produtos por lista: ${value?.averagePurchasedProductsPerList}"),
                Text(
                    "Total de listas compradas: ${value?.totalListsPurchased}"),
                Text(
                    "Total de produtos comprados: ${value?.totalProductsPurchased}"),
                Text("Gastos totais: ${value?.totalSpent}"),
                Text("Gastos do mês: ${value?.totalSpentCurrentMonth}"),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: value?.categoryReports.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 16,),
                            SizedBox(
                              height: 80,
                              width: 340,
                              child: Card(
                                elevation: 4,
                                shadowColor: darkModal,
                                color: value
                                    ?.categoryReports[index].category.color,
                                // surfaceTintColor: value?.categoryReports[index].category.color,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${value?.categoryReports[index].category.name}",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: white)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${value?.categoryReports[index].totalPurchasedQuantity}",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: white)),
                                            Text(" Produtos Comprados",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 12,
                                                    color: white)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Gasto total",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 12,
                                                color: white)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            "R\$${value?.categoryReports[index].totalSpent}",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: white))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            );
          }),
      bottomNavigationBar: Footer(
        isDark: false,
        isStats: true,
        userStore: widget.userStore,
      ),
    );
  }

  // Text("${value?.categoryReports[index].category.name}", style: TextStyle(color: value?.categoryReports[index].category.color),),

  // Text("Total gasto: ${value?.categoryReports[index].totalSpent}"),
  // Text("Gastos no mês: ${value?.categoryReports[index].totalSpentCurrentMonth}"),
  // Text("Total produtos comprados: ${value?.categoryReports[index].totalPurchasedQuantity}"),
  // Text("Produtos comprados no mês: ${value?.categoryReports[index].currentMonthPurchasedQuantity}"),

  // const SizedBox(height: 4,)
}
