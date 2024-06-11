import 'package:flutter/material.dart';

InputDecoration getInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
      color: Color(0xFFA8A8A8),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600, // Semibold
      fontSize: 10,
    ),
    fillColor: const Color(0xFFFCFCFC),
    filled: true,
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFD8D8D8),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFD8D8D8),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFD8D8D8),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16, // Padding horizontal (x)
      vertical: 8,   // Padding vertical (y)
    ),
  );
}


InputDecoration getInputLoginDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
      color: Color(0xFFA8A8A8),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600, // Semibold
      fontSize: 10,
    ),
    fillColor: const Color(0xFFEEEEEE),
    filled: true,
   

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16, // Padding horizontal (x)
      vertical: 8,   // Padding vertical (y)
    ),
  );
}

InputDecoration getCustomInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
      color: Color(0xFFA0A0A0), // Texto na cor #a0a0a0
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600, // Semibold
      fontSize: 16,
    ),
    fillColor: const Color(0xFFEEEEEE), // Cor de fundo do input #eeeeee
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none, // Sem borda
      borderRadius: BorderRadius.circular(32), // Radius de 32
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none, // Sem borda quando habilitado
      borderRadius: BorderRadius.circular(32),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFF343434), // Borda na cor #343434 ao focar
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(32),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 32, // Padding horizontal (x)
      vertical: 24,   // Padding vertical (y)
    ),
  );
}
