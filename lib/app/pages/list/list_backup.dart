import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/footer/footer.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/list/store/list_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/delete_icon.dart';
import 'package:listedin/app/styles/icons/edit_icon.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.list});

  final ShopList list;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late ListStore store;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    store = ListStore(
      list: widget.list,
      repository: ListRepository(
        HttpClient(),
      ),
    );
    store.setState();
    // print();
  }

  @override
  Widget build(BuildContext context) {
    void toggleEditing() {
      setState(() {
        isEditing = !isEditing;
      });
    }

    String calcListPrice() {
      double totalPrice = 0;
      for (var product in store.state.value!.products!) {
        totalPrice += product.price;
      }

      totalPrice.toStringAsFixed(2).replaceFirst('.', ',');
      return totalPrice.toStringAsFixed(2).replaceFirst('.', ',');
    }

    String calcListQTD() {
      double totalPrice = 0;
      for (var product in store.state.value!.products!) {
        totalPrice += product.quantity;
      }

      return totalPrice
                  .toStringAsFixed(1)
                  .replaceFirst('.', ',')
                  .split(',')[1] ==
              '0'
          ? totalPrice.ceil().toString()
          : totalPrice.toStringAsFixed(1).replaceFirst('.', ',');
    }

    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // isEditing
                          //     ? TextField(
                          //         keyboardType: TextInputType.name,

                          //         style: TextStyle(
                          //             fontFamily: 'Montserrat',
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.w600,
                          //             color: text),
                          //         decoration:  InputDecoration(
                          //           border: InputBorder.none, // Reduzir a densidade para menos espaço
                          //           hintText: store.state.value?.name ?? "Sem nome",
                          //           contentPadding:
                          //               EdgeInsets.zero, // Remover padding
                          //         ),
                          //         maxLines: null, // Permitir múltiplas linhas
                          //       )
                          //     : Text(
                          //         store.state.value!.name.isNotEmpty
                          //             ? store.state.value!.name
                          //             : "Sem nome",
                          //         style: TextStyle(
                          //             fontFamily: 'Montserrat',
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.w600,
                          //             color: text),
                          //       ),
                          const SizedBox(
                            width: 16,
                          ),
                          IconButton(
                            icon: EditIcon(color: primary, size: 16),
                            onPressed: () {
                              toggleEditing();
                            },
                          )
                        ],
                      ),
                      ValueListenableBuilder<ShopList?>(
                        valueListenable: store.state,
                        builder: (context, shopList, _) {
                          return Text(
                            "Próximo agendamento para aquele dia.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: text),
                          );
                        },
                      ),
                      ValueListenableBuilder<ShopList?>(
                        valueListenable: store.state,
                        builder: (context, shopList, _) {
                          return Text(
                            "Lista comprada ${store.state.value?.purchasedQuantity ?? 0} vezes.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: text),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      store.deleteList();
                      // Navigator.pop(context);
                    },
                    icon: DeleteIcon(color: primary, size: 28))
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
            child: TextField(
              onChanged: (value) {
                store.searchProducts(value);
              },
              keyboardType: TextInputType.name,
              style: const TextStyle(
                color: Color(0xFFA8A8A8),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600, // Semibold
                fontSize: 10,
              ),
              decoration: getInputDecoration('Busque por seus produtos aqui!'),
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation:
                  Listenable.merge([store.isLoading, store.state, store.error]),
              builder: (context, child) {
                if (store.state.value!.products!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                    child: ListView.builder(
                      itemCount: store.state.value!.products!.length,
                      itemBuilder: (context, index) {
                        final item = store.state.value!.products![index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: CardBuy(
                                productList: item,
                                product: item.product,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primary),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "RS ${calcListPrice()}",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primary),
                    ),
                    Text(
                      "QTD. ${calcListQTD()}",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primary),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
            child: Row(
              children: [
                Button(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors
                                  .transparent, // Adiciona transparência para o espaço fora do modal
                              child: Wrap(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32),
                                        topRight: Radius.circular(32),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Adiciona isso para o column ocupar apenas o espaço necessário
                                      children: [
                                        Text(
                                          "Deseja comprar ou entrar em modo mercado?",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: text),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          "No modo mercado você começa suas compras, podendo utilizar a lista como checagem para tudo que já foi pego e o que ainda falta.",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: text),
                                        ),
                                        const SizedBox(height: 32),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Button(
                                              onPressed: () async {
                                                await store
                                                    .patchPurchasedQuantity();
                                              },
                                              content: "Comprar ",
                                              color: primary,
                                            ),
                                            const SizedBox(width: 16),
                                            Button(
                                              onPressed: () {},
                                              content: "Modo Mercado",
                                              color: red,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    content: 'Comprar',
                    color: primary),
                const SizedBox(
                  width: 16,
                ),
                Button(onPressed: () {}, content: 'Fazer Login', color: primary)
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
      bottomNavigationBar:
          Footer(isDark: false),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
