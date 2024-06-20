import 'package:flutter/material.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/combobox/combobox.dart';
import 'package:listedin/app/components/overlay/overlay.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/pages/list/store/list_store.dart';
import 'package:listedin/app/pages/market_mode/market_mode.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/texts.dart';

class FocusMode extends StatefulWidget {
  FocusMode({super.key, required this.store, required this.user});

  final ListStore store;
  final UserStore user;

  @override
  State<FocusMode> createState() => _FocusModeState();
}

class _FocusModeState extends State<FocusMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                            return Dismissible(
                              background: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(48, 16, 48, 16),
                                color: red,
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              secondaryBackground: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(48, 16, 48, 16),
                                color: primary,
                                alignment: Alignment.centerRight,
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
                            return Dismissible(
                              background: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(48, 16, 48, 16),
                                color: red,
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              secondaryBackground: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(48, 16, 48, 16),
                                color: primary,
                                alignment: Alignment.centerRight,
                                child: const Icon(
                                  Icons.shopping_bag,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (direction) {
                                widget.store.unBuyProduct(index);
                              },
                              key: Key(index.toString()),
                              child: CardBuy(
                                productList: item.product,
                                product: item.product.product,
                              ),
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
                                  products: widget.user.state.value!.createdProducts!,
                                  fnProduct: (product) {
                                    widget.store.addProductToList(product);
                                  }),
                              ButtonModalProps("Novo", function: () {}),
                              ButtonModalProps("Adicionar", function: () async {
                                await widget.store.confirmProductToList();
                                Navigator.pop(context);
                              })));
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      color: text,
                      height: 60,
                      width: 60,
                      child: const Icon(Icons.arrow_back_rounded)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
