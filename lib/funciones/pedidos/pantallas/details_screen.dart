import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String nombre;
  final double precio;

  const DetailsScreen({
    super.key,
    required this.nombre,
    required this.precio,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int cantidad = 1;
  bool agregarExtraQueso = false;
  String nota = '';

  double get total => widget.precio * cantidad + (agregarExtraQueso ? 0.75 : 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Imagen / Stack representativo
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 100,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Nombre y precio
              Text(
                widget.nombre,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                '\$${widget.precio.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 16),

              // Cantidad selector (Row con IconButton)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() => cantidad = (cantidad > 1 ? cantidad - 1 : 1)),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Cantidad: $cantidad', style: const TextStyle(fontSize: 16)),
                  ),
                  IconButton(
                    onPressed: () => setState(() => cantidad++),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Opciones: switch / checkbox example
              Row(
                children: [
                  Checkbox(
                    value: agregarExtraQueso,
                    onChanged: (v) => setState(() => agregarExtraQueso = v ?? false),
                  ),
                  const Text('Extra queso (+\$0.75)'),
                ],
              ),

              const SizedBox(height: 8),

              // TextField para notas
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nota para el restaurante',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                onChanged: (v) => setState(() => nota = v),
              ),

              const Spacer(),

              // Total y botón de agregar al carrito
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: _agregarAlCarrito,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Agregar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _agregarAlCarrito() {
    // En apps reales aquí enviarías el item al carrito (Provider/Riverpod/Bloc)
    // Por ahora mostramos un Snackbar con la info
    final extras = agregarExtraQueso ? ' + queso' : '';
    final mensaje = 'Agregaste ${widget.nombre} x$cantidad$extras\nNota: ${nota.isEmpty ? '—' : nota}';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );

    // Si quieres volver a la pantalla anterior:
    // Navigator.pop(context);
  }
}
