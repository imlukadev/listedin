import 'package:flutter/material.dart';
import 'package:listedin/app/components/overlay/overlay.dart';
import 'package:listedin/app/pages/login/login.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/texts.dart';
import 'package:listedin/main.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final UserStore userStore;

  const Header({
    super.key,
    required this.userStore,
    this.isDarkMode = false,
  });
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
                TextButton(
                  onPressed: () {
                    // Navegar para a segunda página
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyApp(//mudar para home qnd tiver uma
                                ),
                      ),
                    );
                  },
                  child: Image.asset(
                    isDarkMode ? 'assets/whiteLogo.png' : 'assets/onelogo.png',
                    width: 32,
                    height: 32,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          showModal(
                              context,
                              loadModal(
                                  Text(
                                    "Deseja mesmo fazer logout?",
                                    style: titleModal,
                                  ),
                                  Text(
                                    "Pedimos para que continue com a gente!",
                                    style: bodyModal,
                                  ),
                                  ButtonModalProps("Não",
                                      function: () => Navigator.pop(context)),
                                  ButtonModalProps("Sim", function: () {
                                    userStore.state.value = null;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginPage(
                                              title: "Opa login")),
                                    );
                                  })));
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          color: primary,
                        )),
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
