import 'package:flutter/material.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/arrow.dart';

class Button extends StatelessWidget {
  final String Function() onPressed;
  final String content;
  final bool isLogin;
  final Color color;
  final bool isGoogle;
  final bool textBlack;

  const Button(
      {super.key,
      this.isGoogle = false,
      this.textBlack = false,
      required this.onPressed,
      required this.content,
      required this.color,
      this.isLogin = false});

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return color.withOpacity(0.9);
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(getColor),
            foregroundColor: MaterialStateProperty.resolveWith(getColor),
            backgroundColor: MaterialStateProperty.resolveWith(getColor),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.fromLTRB(32, 24, 32, 24)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          child: Expanded(
            child: Row(
              children: [
                isLogin
                    ? Image.asset(
                        isGoogle ? 'assets/google.png' : 'assets/github.png',
                        width: 24,
                        height: 24,
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      content,
                      style: TextStyle(
                        color: textBlack ? text : white,
                      ),
                    ),
                  ),
                ),
                isLogin
                    ? RotatedBox(
                        quarterTurns: 2,
                        child: ArrowIcon(color: white, size: 24),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
