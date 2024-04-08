import 'package:flutter/material.dart';

Future<int?> showPopupMenu(BuildContext context, GlobalKey key,
    List<String> choices, int xMargin, int yMargin) async {
  RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero);
  final screenSize = MediaQuery.of(context).size;
  return await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx + xMargin,
      position.dy + yMargin,
      screenSize.width - position.dx - xMargin,
      screenSize.height - position.dy - yMargin,
    ),
    items: choices.map((e) {
      return PopupMenuItem(
        value: choices.indexOf(e),
        child: Text(e),
      );
    }).toList(),
    elevation: 8.0,
  );
}
