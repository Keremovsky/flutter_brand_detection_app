import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPopUpMenuButton extends ConsumerWidget {
  const HistoryPopUpMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuAnchor(
      style: const MenuStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(5)),
      ),
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: const Icon(
            Icons.more_vert_outlined,
            size: 24,
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: () {},
          child: const Text("Kaydet"),
        ),
        MenuItemButton(
          onPressed: () {},
          child: const Text("Sil"),
        ),
      ],
    );
  }
}
