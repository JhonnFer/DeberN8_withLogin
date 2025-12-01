import 'package:flutter/material.dart';


class AppLogo extends StatelessWidget {
final double size;
const AppLogo({super.key, this.size = 48});


@override
Widget build(BuildContext context) {
return Row(
children: [
Icon(Icons.fastfood, size: size, color: Theme.of(context).primaryColor),
const SizedBox(width: 8),
const Text('Pedidos', style: TextStyle(fontWeight: FontWeight.bold))
],
);
}
}