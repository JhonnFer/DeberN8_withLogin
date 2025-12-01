import 'package:flutter/material.dart';


class OrderSummary extends StatelessWidget {
const OrderSummary({super.key});


@override
Widget build(BuildContext context) {
return SizedBox(
height: 320,
child: Column(
children: [
Container(height: 6, width: 40, margin: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12))),
const ListTile(leading: Icon(Icons.location_on), title: Text('Dirección'), subtitle: Text('Av. Principal #123')),
const Divider(),
Expanded(
child: ListView(
children: const [
ListTile(title: Text('Hamburguesa x2'), trailing: Text('\$7.00')),
ListTile(title: Text('Papas x1'), trailing: Text('\$2.50')),
],
),
),
Padding(
padding: const EdgeInsets.all(12.0),
child: Row(
children: [
const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
const Spacer(),
ElevatedButton(onPressed: () {}, child: const Text('Pagar'))
],
),
)
],
),
);
}
}