import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 20),
      child: Transform.rotate(
        angle: 3.14159 / 2,
        child: Icon(
          Icons.play_arrow_sharp,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 20,
        ),
      ),
    );
  }
}
