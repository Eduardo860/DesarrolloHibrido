import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;

  const NumberInput({
    super.key,
    required this.controller,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Número',
        hintText: hint,
        prefixIcon: const Icon(Icons.numbers),
      ),
    );
  }
}
