import 'package:flutter/material.dart';
import 'package:listedin/app/components/footer/footer.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/pages/stats/stats_store.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/texts.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Text(
                    "Dados Gerais!",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primary),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: primary, width: 1),
                            borderRadius: BorderRadius.circular(16),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.15),
                            //     // spreadRadius: 5,
                            //     blurRadius: 4,
                            //     offset: const Offset(
                            //         0, 0), // changes position of shadow
                            //   ),
                            // ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: Column(
                              children: [
                                Text(
                                  "Produtos Comprados",
                                  style: textPrimaryStats,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${value?.totalProductsPurchased}",
                                  style: boldPrimaryTextStats,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(16),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.15),
                            //     // spreadRadius: 5,
                            //     blurRadius: 4,
                            //     offset: const Offset(
                            //         0, 0), // changes position of shadow
                            //   ),
                            // ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: Column(
                              children: [
                                Text(
                                  "Listas Compradas",
                                  style: textStats,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${value?.totalListsPurchased}",
                                  style: boldTextStats,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(16),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.15),
                            //     // spreadRadius: 5,
                            //     blurRadius: 4,
                            //     offset: const Offset(
                            //         0, 0), // changes position of shadow
                            //   ),
                            // ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: Column(
                              children: [
                                Text(
                                  "Gastos do Mês",
                                  style: textStats,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "R\$${value?.totalSpentCurrentMonth.toStringAsFixed(2).replaceFirst('.', ',')}",
                                  style: boldTextStats,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: primary, width: 1),
                            borderRadius: BorderRadius.circular(16),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.15),
                            //     // spreadRadius: 5,
                            //     blurRadius: 4,
                            //     offset: const Offset(
                            //         0, 0), // changes position of shadow
                            //   ),
                            // ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: Column(
                              children: [
                                Text(
                                  "Gastos Totais",
                                  style: textPrimaryStats,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "R\$${value?.totalSpent.toStringAsFixed(2).replaceFirst('.', ',')}",
                                  style: boldPrimaryTextStats,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: Text(
                    "Dados por Categorias!",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primary),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.builder(
                      itemCount: value?.categoryReports.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 96,
                              width: double.infinity,
                              child: Card(
                                  elevation: 1,
                                  shadowColor: darkModal,
                                  color: value
                                      ?.categoryReports[index].category.color,
                                  // surfaceTintColor: value?.categoryReports[index].category.color,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16,),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: white)),
                                                Text(" Produtos Comprados",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
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
                                                "R\$${value?.categoryReports[index].totalSpent.toStringAsFixed(2).replaceFirst('.', ',')}",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: white))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      }),
                ))
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
