import 'package:flutter/material.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/icons/arrow.dart';
import 'package:listedin/app/styles/texts.dart';

class Button extends StatelessWidget {
  final dynamic Function() onPressed;
  final String content;
  final bool isLogin;
  final Color color;
  final bool isGoogle;
  final bool textBlack;
  final bool small;

  const Button(
      {super.key,
      this.isGoogle = false,
      this.textBlack = false,
      this.small = false,
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
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(getColor),
          foregroundColor: MaterialStateProperty.resolveWith(getColor),
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
          padding: small
              ? const MaterialStatePropertyAll(EdgeInsets.fromLTRB(0, 0, 0, 0))
              : const MaterialStatePropertyAll(
                  EdgeInsets.fromLTRB(32, 24, 32, 24)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: white),
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
    );
  }
}
