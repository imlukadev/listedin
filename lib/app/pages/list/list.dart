import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/combobox/combobox.dart';
import 'package:listedin/app/components/footer/footer.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/components/listStats/list_stats.dart';
import 'package:listedin/app/components/overlay/overlay.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/list/store/list_store.dart';
import 'package:listedin/app/pages/lists/store/lists_store.dart';
import 'package:listedin/app/pages/market_mode/market_mode.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/delete_icon.dart';
import 'package:listedin/app/styles/icons/edit_icon.dart';
import 'package:listedin/app/styles/texts.dart';

class ListPage extends StatefulWidget {

  ListPage({super.key, required this.list, required this.listsStore, required this.user});
 
  final User user;
  ListsStore listsStore;
  final ShopList list;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _searchController = TextEditingController();
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
      double totalQuantity = 0;
      for (var product in store.state.value!.products!) {
        totalQuantity += product.quantity;
      }

      return totalQuantity
                  .toStringAsFixed(1)
                  .replaceFirst('.', ',')
                  .split(',')[1] ==
              '0'
          ? totalQuantity.ceil().toString()
          : totalQuantity.toStringAsFixed(1).replaceFirst('.', ',');
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
                      showModal(
                          context,
                          loadModal(
                              Text(
                                "Deseja mesmo deletar essa lista?",
                                style: titleModal,
                              ),
                              Text(
                                "A lista não será recuperável uma vez que você deletar, tome cuidado!",
                                style: bodyModal,
                              ),
                              ButtonModalProps("Cancelar",
                                  function: () => Navigator.pop(context)),
                              ButtonModalProps("Deletar", function: () async {
                                await store.deleteList();
                                widget.listsStore.state.value.removeWhere((list) => list.id == widget.list.id);
                                widget.listsStore.state.value = List.from(widget.listsStore.state.value);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              })));
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
              controller: _searchController,
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
                              onTap: () {
                                showModal(
                                    context,
                                    loadModal(
                                        Text(
                                          "Edite a quantidade do produto!",
                                          style: titleModal,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Quantidade"),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      store.quantityToPatch(
                                                          value);
                                                    },
                                                    decoration:
                                                        getInputDecoration(
                                                            "Quantidade"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        ButtonModalProps("Remover",
                                            function: () {}),
                                        ButtonModalProps("Salvar",
                                            function: () async {
                                          await store.patchProductList(
                                              item, index);
                                          Navigator.pop(context);
                                        })));
                              },
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
                  return const SizedBox();
                }
              },
            ),
          ),
          ValueListenableBuilder<ShopList?>(
              valueListenable: store.state,
              builder: (context, shopList, _) {
                return ListStats(
                    price: calcListPrice(), quantity: calcListQTD());
              }),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
            child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Button(
                      onPressed: () {
                        showModal(
                            context,
                            loadModal(
                                Text(
                                  "Busque por um produto seu!",
                                  style: titleModal,
                                ),
                                ComboboxProduct(
                                    products: widget.user.createdProducts!,
                                    fnProduct: (product) {
                                      store.addProductToList(product);
                                    }),
                                ButtonModalProps("Novo", function: () {}),
                                ButtonModalProps("Adicionar",
                                    function: () async {
                                  await store.confirmProductToList();
                                  Navigator.pop(context);
                                })));
                      },
                      content: "Adicionar Produto",
                      color: primary,
                      small: true,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Button(
                        small: true,
                        onPressed: () {
                          showModal(
                              context,
                              loadModal(
                                  Text(
                                    "Deseja comprar ou entrar em modo mercado?",
                                    style: titleModal,
                                  ),
                                  Text(
                                      "No modo mercado você começa suas compras, podendo utilizar a lista como checagem para tudo que já foi pego e o que ainda falta além de ver o preço em tempo real.",
                                      style: bodyModal),
                                  ButtonModalProps("Modo mercado",
                                      function: () {
                                    Navigator.pop(context);
                                    store.searchProducts("");
                                    _searchController.clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MarketMode(
                                          user: widget.user,
                                          store: store,
                                        ),
                                      ),
                                    );
                                  }),
                                  ButtonModalProps("Comprar",
                                      function: () async {
                                    await store.patchPurchasedQuantity();
                                    Navigator.pop(context);
                                  })));
                        },
                        content: 'Comprar',
                        color: primary),
                  ],
                )),
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
