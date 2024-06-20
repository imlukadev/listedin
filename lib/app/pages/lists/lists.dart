import 'package:flutter/material.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/footer/footer.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/list/list.dart';
import 'package:listedin/app/pages/lists/store/lists_store.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';
import 'package:listedin/app/styles/colors.dart';

import '../../data/model/user.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key, required this.userStore});

  final UserStore userStore;

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  final TextEditingController _searchController = TextEditingController();
  late ListsStore store;

  @override
  void initState() {
    super.initState();
    store = ListsStore(
      user: widget.userStore.state.value!,
      repository: ListRepository(
        HttpClient(),
      ),
    );
    store.getLists();
    // print();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ShopList list = await store.createList();
          _searchController.clear();
          store.searchLists('');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListPage(
                list: list,
                userStore: widget.userStore,
              ),
            ),
          );
        },
        tooltip: 'Criar lista',
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
              "Suas Listas!",
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
                    controller: _searchController,
                    onChanged: (value) {
                      store.searchLists(value);
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
                            InkWell(
                              onTap: () {
                                // Navegar para a segunda página
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListPage(
                                      list: item,
                                      userStore: widget.userStore,
                                    ),
                                  ),
                                );
                              },
                              child: CardBuy(
                                isList: true,
                                list: item,
                                toggleFavorited: () {
                                  store.patchIsFavorited(item);
                                },
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
          )
        ],
      ),
      bottomNavigationBar: Footer(
        isLists: true,
        userStore: widget.userStore,
        isDark: false,
      ),
    );
  }
}
