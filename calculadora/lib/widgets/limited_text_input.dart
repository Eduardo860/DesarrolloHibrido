import 'package:flutter/material.dart';

class LimitedTextInput extends StatelessWidget {
  final TextEditingController controller;
  final int maxChars;
  final String? helper;
  final String? errorText; 

  const LimitedTextInput({
    super.key,
    required this.controller,
    required this.maxChars,
    this.helper,
    this.errorText, 
  });

  @override
  Widget build(BuildContext context) {
    final enabled = maxChars > 0 && errorText == null;

    return TextField(
      controller: controller,
      enabled: enabled,
      maxLength: enabled ? maxChars : null,
      decoration: InputDecoration(
        labelText: 'Texto limitado',
        helperText: helper,
        errorText: errorText, 
        counterText: enabled ? null : '—',
        hintText: enabled ? 'Máx. $maxChars caracteres' : 'Calcula primero',
        prefixIcon: const Icon(Icons.text_fields),
      ),
    );
  }
}
