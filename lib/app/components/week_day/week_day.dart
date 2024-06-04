import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/styles/colors.dart';

class WeekDay extends StatefulWidget {
  final DateTime date;
  final bool darkModeOn;
  
  final ListRepository listRepository;

  const WeekDay({
    super.key,
    required this.date,
    required this.darkModeOn,
    required this.listRepository,
  });

  @override
  State<WeekDay> createState() => _WeekDayState();
}

class _WeekDayState extends State<WeekDay> {

 List<ShopList> allShopLists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchShopLists();
  }

  Future<void> fetchShopLists() async {
    try {
      print("opa estou pegando as listas mano");
      print(await widget.listRepository.findAll());
      allShopLists = await widget.listRepository.findAll();
      print("opa peguei");
      print(allShopLists);

      // // Divida as listas de compras entre os dias da semana de forma fictícia
      // for (int i = 0; i < allShopLists.length; i++) {
      //   shopListsPerDay[i % 7].add(allShopLists[i]);
      // }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Trate o erro aqui
      print("Erro ao buscar listas de compras: $e");
    }
  }


  bool isDateToday(DateTime date) {
    DateTime now = DateTime.now();
    return now.year == date.year && now.month == date.month && now.day == date.day;
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.darkModeOn ? white : (isDateToday(widget.date) ? white : Colors.black);
    Color listCircleColor = widget.darkModeOn ? white : (isDateToday(widget.date) ? white : primary);

    String dayName = DateFormat('EEE', 'pt_BR').format(widget.date); // Nome do dia (abreviado)
    String dayNumber = DateFormat('d').format(widget.date); // Número do dia

    return SizedBox(
      width: 56,
      height: 96,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: isDateToday(widget.date) ? primary : (widget.darkModeOn ? darkModal : white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              dayName,
              style: TextStyle(color: textColor, fontSize: 10),
            ),
            const SizedBox(height: 10),
            Text(
              dayNumber,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListCircleRow(circleSize: 4, color: listCircleColor, listCount: allShopLists.length),
          ],
        ),
      ),
    );
  }
}

class ListCircleRow extends StatelessWidget {
  final Color color;
  final double circleSize;
  final int listCount; // Número de listas de compras

  const ListCircleRow({
    super.key,
    required this.color,
    required this.circleSize,
    required this.listCount,
  });

  @override
  Widget build(BuildContext context) {
    int firstRowCount = listCount > 4 ? 4 : listCount;
    int secondRowCount = listCount > 4 ? listCount - 4 : 0;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            firstRowCount,
            (i) => ListCircle(size: circleSize, color: color),
          ),
        ),
        if (secondRowCount > 0)
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              secondRowCount,
              (i) => ListCircle(size: circleSize, color: color),
            ),
          ),
      ],
    );
  }
}

class ListCircle extends StatelessWidget {
  final double size;
  final Color color;

  const ListCircle({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
