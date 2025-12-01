import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart';
import '../widgets/order_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool entregaDomicilio = true;
  bool sinPicante = false;
  int tipoEnvio = 0; // 0 normal, 1 express
  String busqueda = '';

  final List<FoodItem> menu = List.generate(
    8,
    (i) => FoodItem(id: i, nombre: 'Hamburguesa ${i + 1}', precio: 3.5 + i),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Pedidos'),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: _openSummary),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text('Menú', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(leading: const Icon(Icons.home), title: const Text('Inicio'), onTap: () => Navigator.pop(context)),
            ListTile(leading: const Icon(Icons.person), title: const Text('Perfil'), onTap: () {}),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row + TextField (tu fragmento completado)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Buscar comida...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => setState(() => busqueda = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: () {}, child: const Text('Buscar')),
                ],
              ),
              const SizedBox(height: 12),

              // Switch, Checkbox, Radio
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade100),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Entrega a domicilio'),
                        const Spacer(),
                        Switch(value: entregaDomicilio, onChanged: (v) => setState(() => entregaDomicilio = v)),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: sinPicante, onChanged: (v) => setState(() => sinPicante = v ?? false)),
                        const Text('Sin picante'),
                        const SizedBox(width: 16),
                        Radio<int>(value: 0, groupValue: tipoEnvio, onChanged: (v) => setState(() => tipoEnvio = v ?? 0)),
                        const Text('Normal'),
                        Radio<int>(value: 1, groupValue: tipoEnvio, onChanged: (v) => setState(() => tipoEnvio = v ?? 0)),
                        const Text('Express'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Stack (completado)
              SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.fastfood, size: 48, color: Colors.grey),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Promoción: Combo Familiar - 20% OFF',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Expanded con ListView (categorías) y GridView (menú)
              Expanded(
                child: Row(
                  children: [
                    // Categorías - ListView
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Categorías', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView(
                              children: const [
                                ListTile(leading: Icon(Icons.local_pizza), title: Text('Pizzas')),
                                ListTile(leading: Icon(Icons.ramen_dining), title: Text('Noodles')),
                                ListTile(leading: Icon(Icons.local_cafe), title: Text('Bebidas')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Menú - GridView
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Menú', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: menu.length,
                              itemBuilder: (context, index) {
                                final item = menu[index];
                                if (busqueda.isNotEmpty && !item.nombre.toLowerCase().contains(busqueda.toLowerCase())) {
                                  return const SizedBox.shrink();
                                }
                                return FoodCard(
                                  nombre: item.nombre,
                                  precio: item.precio,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/details',
                                    arguments: {'nombre': item.nombre, 'precio': item.precio},
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton.icon(onPressed: _openSummary, icon: const Icon(Icons.receipt_long), label: const Text('Resumen pedido')),
              const SizedBox(width: 12),
              OutlinedButton(onPressed: () {}, child: const Text('Limpiar')),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('Soporte')),
            ],
          ),
        ),
      ),
    );
  }

  void _openSummary() {
    showModalBottomSheet(context: context, builder: (_) => const OrderSummary());
  }
}
