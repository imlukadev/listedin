import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/home/home.dart';
import 'package:listedin/app/pages/lists/lists.dart';
import 'package:listedin/app/pages/products/products.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/home_icon.dart';
import 'package:listedin/app/styles/icons/lists_icon.dart';
import 'package:listedin/app/styles/icons/products_icon.dart';
import 'package:listedin/app/styles/icons/stats_icon.dart';
import 'package:listedin/app/styles/texts.dart';

class Footer extends StatelessWidget {
  final bool isDark;
  final bool isLists;
  final bool isProducts;
  final UserStore userStore;
  const Footer(
      {super.key,
      required this.isDark,
      required this.userStore,
      this.isLists = false,
      this.isProducts = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDark ? darkModal : white,
      surfaceTintColor: isDark ? darkModal : white,
      // shadowColor: darkModal,
      elevation: 8,
      margin: EdgeInsets.zero,
      shape: const Border(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // StatsRedirect(isDark: isDark, ),
            // HomeRedirect(isDark: isDark, ),
            ListsRedirect(
              isSelected: isLists,
              userStore: userStore,
              isDark: isDark,
            ),
            Productsredirect(
              userStore: userStore,
              isDark: isDark,
              isSelected: isProducts,
            )
          ],
        ),
      ),
    );
  }
}

class Productsredirect extends StatelessWidget {
  final bool isDark;
  final bool isSelected;
  final UserStore userStore;

  const Productsredirect(
      {super.key,
      required this.isDark,
      required this.isSelected,
      required this.userStore});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(color: isDark ? white : (isSelected ? primary : darkModal));
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
                      builder: (context) => ProductsPage(
                            key: key,
                            userStore: userStore,
                          )),
                );
              },
              child: ProductsIcon(
                color: isSelected ? primary : text,
                key: key,
                size: 32,
              )),
          Text("Produtos", style: textFooter),
          const SizedBox(
            height: 4,
          ),
          isSelected
              ? Container(
                  width: 27,
                  height: 2,
                  color: primary,
                )
              : const SizedBox(
                  height: 2,
                ),
          const SizedBox(
            height: 2,
          ),
          isSelected
              ? Container(
                  width: 8,
                  height: 2,
                  color: primary,
                )
              : const SizedBox(
                  height: 2,
                ),
        ]);
  }
}

class ListsRedirect extends StatelessWidget {
  final bool isDark;
  final UserStore userStore;
  final bool isSelected;

  const ListsRedirect(
      {super.key,
      required this.isDark,
      required this.isSelected,
      required this.userStore});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(color: isDark ? white : (isSelected ? primary : darkModal));
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
                            userStore: userStore,
                            key: key,
                          )),
                );
              },
              child: ListsIcon(
                color: isSelected ? primary : text,
                key: key,
                size: 32,
              )),
          Text("Listas", style: textFooter),
          const SizedBox(
            height: 4,
          ),
          isSelected
              ? Container(
                  width: 27,
                  height: 2,
                  color: primary,
                )
              : const SizedBox(
                  height: 2,
                ),
          const SizedBox(
            height: 2,
          ),
          isSelected
              ? Container(
                  width: 8,
                  height: 2,
                  color: primary,
                )
              : const SizedBox(
                  height: 2,
                ),
        ]);
  }
}

class HomeRedirect extends StatelessWidget {
  final bool isDark;
  final bool isSelected = false;

  const HomeRedirect({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(color: isDark ? white : (isSelected ? primary : darkModal));
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
                      builder: (context) => HomePage(
                            title: "Home Button",
                            darkModeOn: isDark,
                            key: key,
                          )),
                );
              },
              child: HomeIcon(
                color: isDark ? white : (isSelected ? primary : darkModal),
                key: key,
                size: 32,
              )),
          Text(
            "Home",
            style: textStyle,
          ),
        ]);
  }
}

class StatsRedirect extends StatelessWidget {
  final bool isDark;
  final bool isSelected = false;

  const StatsRedirect({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(color: isDark ? white : (isSelected ? primary : darkModal));
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
                      builder: (context) => HomePage(
                            title: "Stats Button",
                            darkModeOn: isDark,
                            key: key,
                          )),
                );
              },
              child: StatsIcon(
                color: isDark ? white : (isSelected ? primary : darkModal),
                key: key,
                size: 32,
              )),
          Text(
            "Estatísticas",
            style: textStyle,
          ),
        ]);
  }
}
