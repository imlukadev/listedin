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
