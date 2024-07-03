import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/category.dart';
import 'package:listedin/app/data/model/product.dart';
import 'package:listedin/app/styles/colors.dart';
import 'package:listedin/app/styles/texts.dart';

class Combobox extends StatefulWidget {
  Combobox(
      {super.key,
      required this.categories,
      required this.fnCategory,
      this.selectedValue});
  final List<Category> categories;
  Category? selectedValue;
  final dynamic Function(Category category) fnCategory;
  @override
  State<Combobox> createState() => _ComboboxState();
}

class _ComboboxState extends State<Combobox> {
  Category? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.selectedValue!=null){
      selectedValue = widget.categories
          .where((element) => element.id ==  widget.selectedValue!.id)
          .toList()[0];
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Category>(
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: selectedValue == null ? text : selectedValue!.color,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.unfold_more,
            size: 16,
            color: Colors.black,
          ),
        ),
        isExpanded: true,
        hint: Text(
          'Selecione',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: text,
          ),
        ),
        items: widget.categories
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(item.name,
                        style: TextStyle(fontSize: 14, color: item.color)),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          if (value != null) {
            widget.fnCategory(value);
          }
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD8D8D8), width: 0.5),
          ),
          height: 48,
          width: double.infinity,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          offset: const Offset(0, 252),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              left: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
              right: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
              bottom: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
              top: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.05), // Sombra extremamente leve
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // Deslocamento da sombra
              ),
            ],
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            alignment: Alignment.center,
            height: 50,
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            decoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
              color: Color(0xFFD8D8D8),
            ))),
            child: TextFormField(
              expands: true,
              maxLines: null,
              style: TextStyle(fontSize: 14),
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Busque aqui!',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

class ComboboxProduct extends StatefulWidget {
  const ComboboxProduct(
      {super.key, required this.products, required this.fnProduct});
  final List<Product> products;
  final dynamic Function(Product product) fnProduct;
  @override
  State<ComboboxProduct> createState() => _ComboboxProductState();
}

class _ComboboxProductState extends State<ComboboxProduct> {
  Product? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Product>(
        style: textXsSemibold,
        iconStyleData: IconStyleData(
            icon: Icon(
          Icons.unfold_more,
          size: 16,
          color: text,
        )),
        isExpanded: true,
        hint: Text('Selecione um produto', style: textXsSemibold),
        items: widget.products
            .map((item) => DropdownMenuItem(
                value: item,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(item.name, style: textSmMedium),
                )))
            .toList(),
        value: selectedValue,

        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          if (value != null) {
            widget.fnProduct(value);
          }
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD8D8D8), width: 0.5),
          ),
          height: 48,
          width: double.infinity,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          offset: const Offset(0, 252),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              left: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
              right: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
              bottom: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
              top: BorderSide(
                color: Color(0xFFD8D8D8),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.05), // Sombra extremamente leve
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // Deslocamento da sombra
              ),
            ],
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            alignment: Alignment.center,
            height: 50,
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            decoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
              color: Color(0xFFD8D8D8),
            ))),
            child: TextFormField(
              expands: true,
              maxLines: null,
              style: textSmMedium,
              controller: textEditingController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Busque aqui!',
                  hintStyle: textSmMedium,
                  border: InputBorder.none),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}









// class StyledComboBoxExample extends StatefulWidget {
//   const StyledComboBoxExample({Key? key});

//   @override
//   _StyledComboBoxExampleState createState() => _StyledComboBoxExampleState();
// }

// class _StyledComboBoxExampleState extends State<StyledComboBoxExample> {
//   final List<String> _items = ["Next.js", "React", "Vue", "Angular"];
//   String? _selectedItem;

//   bool _isDropdownOpened = false; // Controla se o dropdown está aberto

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: 
//          Stack(
//           alignment: Alignment.center,
//           children: [
//             if (_isDropdownOpened)
//               Positioned(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 2), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   margin: EdgeInsets.only(top: 4),
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: _items.map((String item) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedItem = item;
//                             _isDropdownOpened =
//                                 false; // Fecha o dropdown ao selecionar um item
//                           });
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(12),
//                           child: Text(
//                             item,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             InputDecorator(
//               decoration: InputDecoration(
//                 labelText: "Higiene",
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: Colors.blue),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _isDropdownOpened = !_isDropdownOpened;
//                         });
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         child: Text(
//                           _selectedItem ?? 'Escolha alguma merda',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Icon(Icons.unfold_more, color: text),
//                 ],
//               ),
//             ),
//           ],
//         ),
//     );
//   }
// }
