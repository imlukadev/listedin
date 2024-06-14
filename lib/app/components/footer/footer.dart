import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/home/home.dart';
import 'package:listedin/app/pages/lists/lists.dart';
import 'package:listedin/app/pages/products/products.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/home_icon.dart';
import 'package:listedin/app/styles/icons/lists_icon.dart';
import 'package:listedin/app/styles/icons/products_icon.dart';
import 'package:listedin/app/styles/icons/stats_icon.dart';

class Footer extends StatelessWidget{

  final ListRepository listRepository;
  final bool isDark;
  const Footer({super.key, required this.listRepository, required this.isDark});

  @override
  Widget build(BuildContext context) {

    return Card(
      color: isDark ? darkModal : white,
      surfaceTintColor: isDark ? darkModal : white,
      // shadowColor: darkModal,
      elevation: 8,
      margin: EdgeInsets.zero,
      shape: const Border(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 80,),
          StatsRedirect(isDark: isDark, listRepository: listRepository,),
          HomeRedirect(isDark: isDark, listRepository:  listRepository,),
          ListsRedirect(isDark: isDark,),
          Productsredirect(isDark: isDark)
        ],
      ),
      
    );
  }

}

class Productsredirect extends StatelessWidget{
  final bool isDark;
  final bool isSelected = false;

   const Productsredirect({super.key, required this.isDark});


  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(color: isDark ? white : (isSelected ? primary : darkModal) );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [ TextButton( 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsPage(
                    key: key, user: User('name', 'email'),
                )),
              );
            }, 
            child:ProductsIcon(color: isDark ? white : (isSelected ? primary : darkModal), key: key, size: 32,)
          ),
          Text("Produtos", style: textStyle),
      ]);
  }
}

class ListsRedirect extends StatelessWidget{

  final bool isDark;
  final bool isSelected = false;

  const ListsRedirect({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(color: isDark ? white : (isSelected ? primary : darkModal) );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [ 
        TextButton( 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListsPage(
                  user: User("teste", 'estouNoFooter@gmail.com'),
                  key: key,
              )),
            );
          }, 
          child:ListsIcon(color: isDark ? white : (isSelected ? primary : darkModal), key: key,size: 32,)
        ),
        Text("Listas", style: textStyle),
        // Container(width: 27, height: 2, color: primary, ),
        // SizedBox( height: 2,),
        // SizedBox(width: 8, height: 2,),

      ]);

  }
}



class HomeRedirect extends StatelessWidget{

  final bool isDark;
  final bool isSelected = false;
  final ListRepository listRepository;
  
  const HomeRedirect({super.key, required this.isDark, required this.listRepository});

  @override
  Widget build(BuildContext context) {
        final TextStyle textStyle = TextStyle(color: isDark ? white : (isSelected ? primary : darkModal) );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [ TextButton( 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  title: "Home Button",
                  listRepository: listRepository,
                  darkModeOn: isDark,
                  key: key,
              )),
            );
          }, 
          child:HomeIcon(color: isDark ? white : (isSelected ? primary : darkModal), key: key,size: 32,)
        ),
        Text("Home", style: textStyle,),
      ]);
  }
}


class StatsRedirect extends StatelessWidget{

  final bool isDark;
  final bool isSelected = false;
  final ListRepository listRepository;
  
  const StatsRedirect({super.key, required this.isDark, required this.listRepository});

  @override
  Widget build(BuildContext context) {
        final TextStyle textStyle = TextStyle(color: isDark ? white : (isSelected ? primary : darkModal) );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [ TextButton( 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  title: "Stats Button",
                  listRepository: listRepository,
                  darkModeOn: isDark,
                  key: key,
              )),
            );
          }, 
          child:StatsIcon(color: isDark ? white : (isSelected ? primary : darkModal), key: key,size: 32,)
        ),
        Text("Estatísticas", style: textStyle,),
      ]);
  }
}