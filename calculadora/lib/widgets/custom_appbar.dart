import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Color background;
  final Color foreground;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.background = Colors.indigo,
    this.foreground = Colors.white,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: background,
      foregroundColor: foreground,
      centerTitle: true,
      title: Text(
        titleText,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      leading: const Icon(Icons.more_vert), // ícono izquierdo
      actions: [
        const Icon(Icons.camera_alt_outlined),
        const SizedBox(width: 12),
        const Icon(Icons.add_circle_outline),
        const SizedBox(width: 8),
      ],
    );
  }
}
