import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/devs/store_luka.dart';
import 'package:listedin/app/styles/colors.dart';

class DevLuka extends StatefulWidget {
  const DevLuka({super.key, required this.title});

  final String title;

  @override
  State<DevLuka> createState() => _DevLukaState();
}

class _DevLukaState extends State<DevLuka> {
  final IListRepository listRepository = ListRepository(HttpClient());
  final ListStore store = ListStore(
    repository: ListRepository(
      HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getLists();
    // print();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header(),
        body: AnimatedBuilder(
          animation:
              Listenable.merge([store.isLoading, store.state, store.error]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if (store.state.value.isNotEmpty) {
              return CardBuy(isList: true, list: store.state.value[0]);
            } else {
              return SizedBox();
            }
          },
        ));
  }
}
