import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final num? value;
  const ResultDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final text = switch (value) {
      null => '—',
      num v when v.isNaN => 'Error',
      num v => v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '')
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
