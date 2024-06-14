import 'package:flutter/material.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/combobox/combobox.dart';
import 'package:listedin/app/components/footer/footer.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/components/overlay/overlay.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/data/repositories/product_repository.dart';
import 'package:listedin/app/pages/products/store/products_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/texts.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.user});
  final User user;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductsStore store;

  @override
  void initState() {
    super.initState();
    store = ProductsStore(
      user: widget.user,
      repository: ProductRepository(HttpClient()),
    );
    store.getProducts();
    store.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(
              context,
              loadModal(
                  Row(
                    children: [
                      Expanded(
                      //     child: Text(
                      //   "Nome do Produto",
                      //   style: titleModal,
                      // ))
                      child:  TextField(
             
              onChanged: (value) => store.updateName(value),
              decoration: InputDecoration(
                hintText: "Nome do Produto",
                hintStyle: titleModal.copyWith(color: Colors.grey),
              )
                      ),
                       ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.edit,
                          color: primary,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Preço"),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              onChanged: (value) {
                                store.updatePrice(value);
                              },
                              decoration: getInputDecoration("Preço"),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Categoria"),
                            SizedBox(
                              height: 8,
                            ),
                            Combobox(
                              categories: store.categoryState.value,
                              fnCategory: (category) {
                                store.uppdateCategory(category);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ButtonModalProps("Cancelar", function: () {
                    Navigator.pop(context);
                  }),
                  ButtonModalProps("Criar", function: () async {
                    await store.createProduct();
                    Navigator.pop(context);
                  })));
        },
        tooltip: 'Criar produto!',
        backgroundColor: primary,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Text(
              "Seus Produtos!",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Row(
              children: [
                Expanded(
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
                    decoration: getInputDecoration('Busque aqui!'),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation:
                  Listenable.merge([store.isLoading, store.state, store.error]),
              builder: (context, child) {
                if (store.isLoading.value) {
                  return const CircularProgressIndicator();
                }

                if (store.state.value.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListView.builder(
                      itemCount: store.state.value.length,
                      itemBuilder: (context, index) {
                        final item = store.state.value[index];
                        return Column(
                          children: [
                            InkWell(child:  CardBuy(
                              isList: false,
                              product: item,
                            ),
                            
                           onTap: (){
              //               showModal(
              // context,
              // loadModal(
              //     Row(
              //       children: [
              //         Expanded(
              //         //     child: Text(
              //         //   "Nome do Produto",
              //         //   style: titleModal,
              //         // ))
              //         child:  TextField(
             
              // onChanged: (value) => store.updateName(value),
              // decoration: InputDecoration(
              //   hintText: "Nome do Produto",
              //   hintStyle: titleModal.copyWith(color: Colors.grey),
              // )
              //         ),
              //          ),
              //         InkWell(
              //           onTap: () {},
              //           child: Icon(
              //             Icons.edit,
              //             color: primary,
              //           ),
              //         )
              //       ],
              //     ),
              //     Row(
              //       children: [
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text("Preço"),
              //               SizedBox(
              //                 height: 8,
              //               ),
              //               TextField(
              //                 onChanged: (value) {
              //                   store.updatePrice(value);
              //                 },
              //                 decoration: getInputDecoration("Preço"),
              //               )
              //             ],
              //           ),
              //         ),
              //         SizedBox(
              //           width: 32,
              //         ),
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text("Categoria"),
              //               SizedBox(
              //                 height: 8,
              //               ),
              //               Combobox(
              //                 categories: store.categoryState.value,
              //                 fnCategory: (category) {
              //                   store.uppdateCategory(category);
              //                 },
              //               )
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //     ButtonModalProps("Cancelar", function: () {
              //       Navigator.pop(context);
              //     }),
              //     ButtonModalProps("Criar", function: () async {
              //       await store.createProduct();
              //       Navigator.pop(context);
              //     })));
                           }, 
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
          )
        ],
      ),
      bottomNavigationBar: Footer( isDark: false),
    );
  }
}
