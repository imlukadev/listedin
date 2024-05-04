import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/styles/colors.dart';

class WeekDay extends StatefulWidget{
  
  // final List<ShopList> lists;
  final DateTime date;
  final bool darkModeOn;


  
  const WeekDay({super.key, 
  // required this.lists, 
  required this.date, required this.darkModeOn,});

  @override
  State<StatefulWidget> createState() => _WeekDayState(
    // lists,
     date, darkModeOn);
}



class _WeekDayState extends State<WeekDay>{

  // final List<ShopList> lists;
  final DateTime date;
  bool darkModeOn;

  bool isDateToday(){
    return DateTime.now().year == date.year && DateTime.now().month == date.month && DateTime.now().day == date.day;
  }

  _WeekDayState(
    // this.lists, 
  this.date, this.darkModeOn);
  

  @override
  Widget build(BuildContext context) {
  Color textColor = (darkModeOn ? white : (isDateToday() ? white : darkModal));
  Color listCircleColor = darkModeOn ? white : (isDateToday() ? white : primary);
    return  SizedBox(
      width: 56,
      height: 96,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: isDateToday() ?  primary : (!darkModeOn ? white : darkModal),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
              Text("Ter", style: TextStyle(color:textColor, fontSize: 10),),
              const SizedBox(height: 10, ),
              Text("14", style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold,),),
              const SizedBox(height: 10,),
              ListCircleRow(circleSize: 4, color: listCircleColor)
            ],
          )
      )
    );
  }

}

class ListCircleRow extends StatelessWidget{
  
  final Color color;
  final double circleSize;

  const ListCircleRow({super.key, required this.color, required this.circleSize });
  

  @override
  Widget build(BuildContext context) {
    return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListCircle(size: circleSize, color: color),
                  const SizedBox(width: 1,),
                  ListCircle(size: circleSize, color: color),
                  const SizedBox(width: 1,),
                  ListCircle(size: circleSize, color: color),
                ],
              );
  }
}


class ListCircle extends StatelessWidget{
  
  final double size;
  final Color color;

  const ListCircle({super.key, required this.size, required this.color}); 

  
  @override
  Widget build(BuildContext context) {
    return Container(height: size, width: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color),);
  }
}