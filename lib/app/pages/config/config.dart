// import 'package:flutter/material.dart';
// import 'package:listedin/app/components/footer/footer.dart';
// import 'package:listedin/app/components/header/header.dart';
// import 'package:listedin/app/data/model/user.dart';
// import 'package:listedin/app/styles/colors.dart';

// class Config extends  StatefulWidget{
  
//   bool isDark;
//   final User user;

//   Config({super.key, required this.isDark, required this.user});

//   @override
//   State<Config> createState() => _ConfigState();
// }

// class _ConfigState extends State<Config> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const Header(),


//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 104, width: 24,),
//                 Container(
//                     height: 64,
//                     width: 64,
//                     margin: const EdgeInsets.all(2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: primary,
//                     ),
//                 ),
//                 const SizedBox(width: 16,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.user.name, style: TextStyle(fontSize: 20),),
//                     Text(widget.user.email)
//                   ],
//                 )  
//               ]
//             ),
//             const SizedBox(height: 24,),
//              Column(
              
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Modo escuro"),
//                     ToggleSwitch(isDark: widget.isDark,)
//                   ],
//                 ),
//                 const Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("texto"),
//                     Text("Input")
//                   ],
//                 ),
//                 const Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("texto"),
//                     Text("Input")
//                   ],
//                 ),
//               ],
//             )
//         ],
//         ),



//       bottomNavigationBar: Footer(isDark: widget.isDark,),
//     );
//   }
// } 



// class ToggleSwitch extends StatefulWidget {
//   bool isDark;
//   // final onChangeFunction;
//   ToggleSwitch({super.key, required this.isDark});

//   @override
//   ToggleSwitchState createState() => ToggleSwitchState();
// }

// class ToggleSwitchState extends State<ToggleSwitch> {
//   // bool isSwitched = false;

//   void _toggleSwitch(bool value) {
//     setState(() {
//       widget.isDark = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: widget.isDark,
//       onChanged: _toggleSwitch,
//       // inactiveTrackColor: darkModal,
//       activeTrackColor: widget.isDark ? text : primary ,
//       activeColor: widget.isDark ? darkModal : white ,
//       // focusColor: darkModal,
//       // hoverColor: darkModal,


//     );
//   }
// }