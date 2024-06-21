import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/combobox/combobox.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/components/listStats/list_stats.dart';
import 'package:listedin/app/components/overlay/overlay.dart';
import 'package:listedin/app/components/week_day/week_day.dart';
import 'package:listedin/app/data/model/product_list.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/pages/focus_mode/focus_mode.dart';
import 'package:listedin/app/pages/list/store/list_store.dart';
import 'package:listedin/app/pages/products/store/products_store.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/arrow.dart';
import 'package:listedin/app/styles/texts.dart';

class ProductsBuy {
  ProductList product;
  bool isBuy;

  ProductsBuy(this.product, this.isBuy);
}

class MarketMode extends StatefulWidget {
  final ListStore store;
  final UserStore user;
  final ProductsStore productsStore;

  const MarketMode({super.key, required this.store, required this.productsStore, required this.user});

  @override
  State<MarketMode> createState() => _MarketModeState();
}

class _MarketModeState extends State<MarketMode> {
  late List<ProductsBuy> products = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = widget.store.state.value!.products!
        .map((e) => ProductsBuy(e, false))
        .toList();
    widget.store.setProducts(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: ArrowIcon(color: text, size: 24)),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar modo mercado",
                      style: textSmMedium,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  widget.store.searchProductsBuy(value);
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Color(0xFFA8A8A8),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600, // Semibold
                  fontSize: 10,
                ),
                decoration:
                    getInputDecoration('Busque por seus produtos aqui!'),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: widget.store.productsState,
                builder: (context, List<ProductsBuy> productsState, _) {
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Itens a comprar!",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productsState.length,
                          itemBuilder: (context, index) {
                            final item = productsState[index];
                            if (!item.isBuy) {
                              return InkWell(
                                child: Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  // background: Container(
                                  //   padding:
                                  //       const EdgeInsets.fromLTRB(48, 16, 48, 16),
                                  //   color: red,
                                  //   alignment: Alignment.centerLeft,
                                  //   child: const Icon(
                                  //     Icons.delete,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  background: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        48, 16, 48, 16),
                                    color: primary,
                                    alignment: Alignment.centerLeft,
                                    child: const Icon(
                                      Icons.shopping_bag,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    widget.store.buyProduct(index);
                                  },
                                  key: Key(index.toString()),
                                  child: CardBuy(
                                    productList: item.product,
                                    product: item.product.product,
                                  ),
                                ),
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
                                                    const Text("Quantidade"),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        widget.store
                                                            .quantityToPatch(
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
                                              function: () {
                                            Navigator.pop(context);
                                            showModal(
                                                context,
                                                loadModal(
                                                    Text(
                                                      "Você deseja remover o produto ${item.product.product.name} da lista?",
                                                      style: titleModal,
                                                    ),
                                                    Text(
                                                        "É importante lembrar que pode ficar tranquilo, o produto continuará na sua listas de produtos, apenas não estará mais nessa lista!"),
                                                    ButtonModalProps("Não",
                                                        function: () {
                                                      Navigator.pop(context);
                                                    }),
                                                    ButtonModalProps("Sim",
                                                        function: () async {
                                                      await widget.store
                                                          .removeProductList(
                                                              item.product,
                                                              index);
                                                      Navigator.pop(context);
                                                    })));
                                          }),
                                          ButtonModalProps("Salvar",
                                              function: () async {
                                            await widget.store.patchProductList(
                                                item.product, index);
                                            Navigator.pop(context);
                                          })));
                                },
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Itens já comprados!",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productsState.length,
                          itemBuilder: (context, index) {
                            final item = productsState[index];
                            if (item.isBuy) {
                              return InkWell(
                                child: Dismissible(
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        48, 16, 48, 16),
                                    color: red,
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // background: Container(
                                  //   padding:
                                  //       const EdgeInsets.fromLTRB(48, 16, 48, 16),
                                  //   color: primary,
                                  //   alignment: Alignment.centerRight,
                                  //   child: const Icon(
                                  //     Icons.shopping_bag,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  onDismissed: (direction) {
                                    widget.store.unBuyProduct(index);
                                  },
                                  key: Key(index.toString()),
                                  child: CardBuy(
                                    productList: item.product,
                                    product: item.product.product,
                                  ),
                                ),
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
                                                    const Text("Quantidade"),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        widget.store
                                                            .quantityToPatch(
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
                                              function: () {
                                            Navigator.pop(context);
                                            showModal(
                                                context,
                                                loadModal(
                                                    Text(
                                                      "Você deseja remover o produto ${item.product.product.name} da lista?",
                                                      style: titleModal,
                                                    ),
                                                    const Text(
                                                        "É importante lembrar que pode ficar tranquilo, o produto continuará na sua listas de produtos, apenas não estará mais nessa lista!"),
                                                    ButtonModalProps("Não",
                                                        function: () {
                                                      Navigator.pop(context);
                                                    }),
                                                    ButtonModalProps("Sim",
                                                        function: () async {
                                                      await widget.store
                                                          .removeProductList(
                                                              item.product,
                                                              index);
                                                      Navigator.pop(context);
                                                    })));
                                          }),
                                          ButtonModalProps("Salvar",
                                              function: () async {
                                            await widget.store.patchProductList(
                                                item.product, index);
                                            Navigator.pop(context);
                                          })));
                                },
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ValueListenableBuilder<double>(
              valueListenable: widget.store.price,
              builder: (context, price, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: widget.store.quantity,
                  builder: (context, quantity, _) {
                    return ListStats(
                      price: price.toStringAsFixed(2).replaceFirst('.', ','),
                      quantity: quantity
                                  .toStringAsFixed(1)
                                  .replaceFirst('.', ',')
                                  .split(',')[1] ==
                              '0'
                          ? quantity.ceil().toString()
                          : quantity.toStringAsFixed(1).replaceFirst('.', ','),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: SizedBox(
                height: 48,
                child: Button(
                  color: primary,
                  content: "Finalizar compra em modo mercado",
                  onPressed: () {
                    widget.store.patchPurchasedQuantity();
                    Navigator.pop(context);
                  },
                  small: true,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              color: primary,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Text(
                        "Adicionar Produto",
                        textAlign: TextAlign.center,
                        style: textMnSemibold,
                      ),
                      onTap: () {
                        showModal(
                            context,
                            loadModal(
                                Text(
                                  "Busque por um produto seu!",
                                  style: titleModal,
                                ),
                                ComboboxProduct(
                                    products: widget
                                        .user.state.value!.createdProducts!,
                                    fnProduct: (product) {
                                      widget.store.addProductToList(product);
                                    }),
                                ButtonModalProps("Novo", function: () {
                                  loadModalProducts(widget.productsStore,
                                      context, false, () {}, (product) async {
                                    widget.store.productToAdd = product;
                                    widget.store.confirmProductToList();
                                  });
                                }),
                                ButtonModalProps("Adicionar",
                                    function: () async {
                                  await widget.store.confirmProductToList();
                                  Navigator.pop(context);
                                })));
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.store.searchProductsBuy('');
                      _searchController.clear();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FocusMode(
                            productsStore: widget.productsStore,
                            user: widget.user,
                            store: widget.store,
                          ),
                        ),
                      );
                    },
                    child: Container(
                        color: text,
                        height: 60,
                        width: 60,
                        child: const Icon(Icons.remove_red_eye)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
