// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    super.key,
    this.errorContent,
  });

  final String? errorContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            color: redColor,
            size: 100,
          ),
          Text(
            (errorContent.isEmptyOrNull)
                ? "Something went wrong.."
                : errorContent!,
            style: const TextStyle(
              color: redColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
