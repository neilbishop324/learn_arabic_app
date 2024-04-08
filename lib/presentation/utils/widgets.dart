import 'package:flutter/material.dart';
import 'package:learn_arabic_app/presentation/utils/widget_functions.dart';
import 'package:nb_utils/nb_utils.dart';

Widget choiceView({
  required BuildContext context,
  required String selectedChoice,
  required List<String> choices,
  required Function(String) onSelectChoice,
  Function()? onClick,
}) {
  GlobalKey containerKey = GlobalKey();

  return InkWell(
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    onTap: () async {
      if (onClick != null) {
        onClick();
        return;
      }
      int? index = await showPopupMenu(context, containerKey, choices, 100, 50);
      if (index != null) {
        onSelectChoice(choices[index]);
      }
    },
    child: Container(
      key: containerKey,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedChoice,
            style: const TextStyle(fontSize: 20),
          ),
          4.width,
          const Icon(Icons.arrow_drop_down_sharp)
        ],
      ).paddingAll(8),
    ),
  );
}
