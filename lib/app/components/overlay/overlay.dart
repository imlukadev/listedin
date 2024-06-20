import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/combobox/combobox.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/pages/products/store/products_store.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/texts.dart';

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

void loadModalProducts(
    ProductsStore store, context, bool isEditing, fnIsEditing) {
  TextEditingController controllerProductName = TextEditingController();
  showModal(
      context,
      loadModal(
          Row(
            children: [
              isEditing
                  ? Expanded(
                      child: TextField(
                      keyboardType: TextInputType.name,
                      autofocus: true,
                      controller: controllerProductName,

                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: text),
                      decoration: const InputDecoration(
                        border: InputBorder
                            .none, // Reduzir a densidade para menos espaço
                        hintText: "Novo Produto",
                        contentPadding: EdgeInsets.zero, // Remover padding
                      ),
                      onChanged: (value) => store.updateName(value),
                      maxLines: null, // Permitir múltiplas linhas
                    ))
                  : Expanded(
                      child: Text(
                        store.signProduct.value.name.isNotEmpty ? store.signProduct.value.name : "Novo produto",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: text),
                      ),
                    ),
              InkWell(
                onTap: () {
                  fnIsEditing();
                },
                child: Icon(
                  Icons.edit,
                  color: primary,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Preço"),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      onChanged: (value) {
                        store.updatePrice(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: getInputDecoration("Preço"),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 32,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Categoria"),
                    SizedBox(
                      height: 8,
                    ),
                    Combobox(
                      categories: store.categoryState.value,
                      fnCategory: (category) {
                        store.uppdateCategory(category);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          ButtonModalProps("Cancelar", function: () {
            Navigator.pop(context);
          }),
          ButtonModalProps("Criar", function: () async {
            await store.createProduct();
            Navigator.pop(context);
          })));
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Adiciona isso para o column ocupar apenas o espaço necessário
                  children: widgets,
                ),
              ),
            ],
          ),
        );
      });
}
