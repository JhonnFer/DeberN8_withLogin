import 'package:flutter/material.dart';


class FoodCard extends StatelessWidget {
final String nombre;
final double precio;
final VoidCallback? onTap;


const FoodCard({super.key, required this.nombre, required this.precio, this.onTap});


@override
Widget build(BuildContext context) {
return GestureDetector(
onTap: onTap,
child: Container(
padding: const EdgeInsets.all(8),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Flexible(
  child: Center(
    child: Icon(Icons.fastfood, size: 40, color: Theme.of(context).primaryColor),
  ),
),

const SizedBox(height: 8),
Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 4),
Row(
  children: [
    Expanded(
      child: Text(
        nombre,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    const SizedBox(width: 4),
    Text(
      '\$${precio.toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 14),
    ),
  ],
)

],
),
),
);
}
}