import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'week_day.dart';

class WeekList extends StatefulWidget {
  final bool darkModeOn;
  final ListRepository listRepository;

  const WeekList({
    Key? key,
    required this.darkModeOn,
    required this.listRepository,
  }) : super(key: key);

  @override
  State<WeekList> createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
  List<List<ShopList>> shopListsPerDay = List.generate(7, (_) => []);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchShopLists();
  }

  Future<void> fetchShopLists() async {
    try {
      List<ShopList> allShopLists = await widget.listRepository.findAll();

      // Divida as listas de compras entre os dias da semana de forma fictícia
      for (int i = 0; i < allShopLists.length; i++) {
        shopListsPerDay[i % 7].add(allShopLists[i]);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Trate o erro aqui
      print("Erro ao buscar listas de compras: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinhar a lista horizontalmente
        children: [
          Row(
            children: [
              ListView.builder(
            shrinkWrap: true,
            itemCount: 5, // Limita a exibição a 5 dias
            itemBuilder: (context, index) {
              DateTime date = startOfWeek.add(Duration(days: index));
              return WeekDay(
                date: date,
                darkModeOn: widget.darkModeOn,
                shopLists: shopListsPerDay[index],
              );
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2, // 2 dias restantes
            itemBuilder: (context, index) {
              DateTime date = startOfWeek.add(Duration(days: 5 + index));
              return WeekDay(
                date: date,
                darkModeOn: widget.darkModeOn,
                shopLists: shopListsPerDay[5 + index],
              );
            },
          ),
            ],
          )
          
        ],
      ),
    );
  }
}
