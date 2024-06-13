import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/styles/colors.dart';

class ButtonModalProps {
  dynamic Function() function;
  String content;

  ButtonModalProps(this.content, {required this.function});
}


List<Widget> loadModal(
    Widget title, Widget body, ButtonModalProps cancel, ButtonModalProps ok) {
  return [
    title,
    const SizedBox(height: 16),
    body,
    const SizedBox(height: 32),

       Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Button(
          onPressed: cancel.function,
          content: cancel.content,
          color: red,
        ),
        const SizedBox(width: 16),
        Button(
          onPressed: ok.function,
          content: ok.content,
          color: primary,
        ),
      ],
    ),
    
   
  ];
}



void showModal(BuildContext context, List<Widget> widgets) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors
              .transparent, // Adiciona transparência para o espaço fora do modal
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, 
                      crossAxisAlignment: CrossAxisAlignment.start,// Adiciona isso para o column ocupar apenas o espaço necessário
                  children: widgets,
                ),
              ),
            ],
          ),
        );
      });
}
