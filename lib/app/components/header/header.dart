import 'package:flutter/material.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/dark_mode_icon.dart';
import 'package:listedin/app/styles/icons/light_mode_icon.dart';
import 'package:listedin/app/styles/icons/profile_icon.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;

  const Header({super.key, this.isDarkMode = false});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(24, 48, 24, 0), // Ajuste o mínimo aqui
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  isDarkMode ? 'assets/whiteLogo.png' : 'assets/onelogo.png',
                  width: 32,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isDarkMode
                        ? LightModeIcon(color: white, size: 32)
                        : DarkModeIcon(color: primary, size: 32),
                    const SizedBox(width: 16, height: 32),
                    ProfileIcon(color: isDarkMode ? white : primary, size: 32),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
