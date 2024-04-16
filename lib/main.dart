import 'package:flutter/material.dart';
import 'package:listedin/app/pages/home/home_page.dart';
import 'package:listedin/app/pages/layout/layout_learning.dart';
import 'package:listedin/app/pages/todo/todo_app.dart';

void main() {
  runApp(const DefaultApp());
}

class DefaultApp extends StatelessWidget {
  const DefaultApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  LayoutLearning());
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   final List<Atracao> _listaFavoritos = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Atrações'),
//       ),
//       body: ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: listaAtracoes.length,
//           itemBuilder: (context, index) {
//             final isFavorito = _listaFavoritos.contains(listaAtracoes[index]);
//             return ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             AtracaoPage(atracao: listaAtracoes[index])));
//               },
//               title: Text(listaAtracoes[index].nome),
//               subtitle: Wrap(
//                 spacing: 8,
//                 runSpacing: 4,
//                 children: listaAtracoes[index]
//                     .tags
//                     .map((tag) => Chip(label: Text('#$tag')))
//                     .toList(),
//               ),
//               leading: CircleAvatar(
//                 child: Text('${listaAtracoes[index].dia}'),
//               ),
//               trailing: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     if (isFavorito) {
//                       _listaFavoritos.remove(listaAtracoes[index]);
//                     } else {
//                       _listaFavoritos.add(listaAtracoes[index]);
//                     }
//                   });
//                 },
//                 icon: isFavorito
//                     ? const Icon(Icons.favorite, color: Colors.red)
//                     : const Icon(Icons.favorite_border),
//               ),
//             );
//           }),
//     );
//   }
// }

// class AtracaoPage extends StatelessWidget {
//   final Atracao atracao;
//   const AtracaoPage({super.key, required this.atracao});

//   @override
//   Widget build(context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(atracao.nome),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             for (var tag in atracao.tags) Chip(label: Text('#$tag')),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Voltar'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Atracao {
//   final String nome;
//   final int dia;
//   final List<String> tags;

//   const Atracao(this.nome, this.dia, this.tags);
// }

// const listaAtracoes = [
//   Atracao("Iron Maiden", 2, ["Espetaculo", "Fas", "NovoAlbum"]),
//   Atracao("Alok", 3, ["Influente", "Top", "Show"]),
//   Atracao("Justin Bieber", 4, ["TopCharts", "Hits", "PríncipeDoPOP"]),
//   Atracao("Guns N’ Roses", 8, ["Sucesso", "Espetáculo", "Fas"]),
//   Atracao("Capital Inicial", 9, ["2019", "Novo Álbum", "Fas"]),
//   Atracao("Green Day", 9, ["Sucesso", "Reconhecimento", "Show"]),
//   Atracao("Cold Play", 10, ["NovoAlbum", "Sucesso", "2011"]),
//   Atracao("Ivete Sangalo", 10, ["Unica", "Carreiras", "Fas"]),
//   Atracao("Racionais", 3, ["Hits", "Prêmios", "Respeito"]),
//   Atracao("Gloria Groove", 8, ["Streams", "Representatividade", "Sucesso"]),
//   Atracao("Avril Lavigne", 9, ["Estreia", "Sucesso", "Lançamento"]),
//   Atracao("Ludmilla", 10, ["Representativade", "Sucesso", "Parcerias"]),
// ];
