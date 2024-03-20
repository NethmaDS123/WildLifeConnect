import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({super.key});

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildDivider(),
            buildButton(context, '42', 'Posts'),
            buildDivider(),
          ],
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 12),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromARGB(255, 120, 120, 120)),
            ),
          ],
        ),
      );

  Widget buildDivider() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        child: const VerticalDivider(),
      );
}
