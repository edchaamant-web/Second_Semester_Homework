import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.action,
    required this.title,
    this.num = 20,
    required this.buttunicon,
  });

  final VoidCallback action;
  final String title;
  final double num;
  final Icon buttunicon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(num, 23, num, 30),
      child: ElevatedButton(
        onPressed: action,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(width: 7),
            buttunicon,
          ],
        ),
      ),
    );
  }
}
