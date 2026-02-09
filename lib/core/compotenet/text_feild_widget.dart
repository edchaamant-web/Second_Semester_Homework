import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  const TextFeildWidget({
    super.key,
    required this.titles,
    this.hints,
    required this.textController,
  });

  final TextEditingController textController;
  final String titles;
  final String? hints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
          child: Align(
            alignment: AlignmentGeometry.centerRight,
            child: Text(titles, style: Theme.of(context).textTheme.labelMedium),
          ),
        ),

        const SizedBox(height: 18),

        TextField(
          controller: textController,
          decoration: InputDecoration(hintText: hints),
        ),
      ],
    );
  }
}
